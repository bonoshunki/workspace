# llm-foundy

[この](https://github.com/mosaicml/llm-foundry)リポジトリについて Tips.

## Checkpoints から再開する

`yaml`に以下を追記. 説明がどこにもなくて困った.

```yaml
load_path: ${PATH_TO_CHECKPOINTS}/latest-rank${RANK}.pt
```

## ReduceLROnPlateau を使いたい（失敗）

`torch.optim.lr_scheduler`の中でも`ReduceLROnPlateau`だけは, metrics を引数に取る必要があるので（loss を監視して LR を変更するから）, 実装が分かれている.

結論から書くと, llm-foundy が使用している`composer`は対応していないので, 自分でゴリゴリに書き換える必要がある. 僕は諦めた. 以下軌跡.

<details>
<summary>挙動を調べたやつ</summary>

まず`train.py`の以下の部分で scheduler を定義している.

```python:llm-foundry/scripts/train/train.py
# Scheduler
scheduler = build_scheduler(cfg.scheduler)
```

その中身は`builders.py`の以下.

```python:llm-foundry/llmfoundry/utils/builders.py
def build_scheduler(cfg):
    if cfg.name == 'constant_with_warmup':
        return ConstantWithWarmupScheduler(t_warmup=cfg.t_warmup)
    elif cfg.name == 'cosine_with_warmup':
        return CosineAnnealingWithWarmupScheduler(t_warmup=cfg.t_warmup,
                                                  alpha_f=cfg.alpha_f)
    elif cfg.name == 'linear_decay_with_warmup':
        return LinearWithWarmupScheduler(t_warmup=cfg.t_warmup,
                                         alpha_f=cfg.alpha_f)
    else:
        raise ValueError(f'Not sure how to build scheduler: {cfg.name}')
```

`composer`は`PyTorchScheduler`をサポートしているが, llm-foundry の方はサポートしていないので注意.

```python
schedulers: Optional[Union[ComposerScheduler, PyTorchScheduler, Sequence[Union[ComposerScheduler,
PyTorchScheduler]]]] = None,
```

`Trainer`に渡された`scheduler`は, `composer`の方で以下のように処理される.

```python:
self.state.schedulers = _compile_schedulers(schedulers, self.state, scale_schedule_ratio)
```

```python:composer/trainer/trainer.py
def _compile_schedulers(
    schedulers: Optional[Union[Scheduler, Sequence[Scheduler]]],
    state: State,
    scale_schedule_ratio: float,
) -> List[PyTorchScheduler]:
    compiled_schedulers = []
    for scheduler in ensure_tuple(schedulers):
        if isinstance(scheduler, PyTorchScheduler):
            scale_pytorch_scheduler(scheduler, scale_schedule_ratio)
            compiled_schedulers.append(scheduler)
        else:  # it's a composer scheduler
            compiled_schedulers.append(compile_composer_scheduler(scheduler, state, scale_schedule_ratio))

    return compiled_schedulers
```

ここで, `PyTorchScheduler`が`ReduceLROnPlateau`を含んでいないことに注意（サポートしていない、死亡）

```python:composer/core/types.py
try:
    PyTorchScheduler = torch.optim.lr_scheduler.LRScheduler
except:
    PyTorchScheduler = torch.optim.lr_scheduler._LRScheduler
```

</details>
