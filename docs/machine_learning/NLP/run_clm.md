# run_clm.py について

GPT-2 等の大規模言語モデルの FineTuning で使われる run_clm.py の中身を見てみた。

## 概要

<!-- main関数内では主に以下の手順で実行している。 -->

<!-- 1.loggingの設定。
2. -->

The following steps are mainly executed within the main function.

1. log settings
1. checkpoint checking
1. dataset loading
1. tokenizer loading
1. model loading
1. preprocessing the datasets
   1. tokenize all the texts.
   1. (Main data processing function) concatenate all texts from our dataset and generate chunks of block_size.
1. Training!
1. Evaluation

### Training

1. Initialize Trainer
1. Train
1. Save model

Train by this code.

```
train_result = trainer.train(resume_from_checkpoint=checkpoint)
```

This calling the train method in the Trainer Class. The train function just do preprocessing and then call the \_inner_training_loop function, also in the Trainer class. The steps in \_inner_training_loop are below.

1. Setting up training control variables:
1. gradient checkpoint checking
1. Check if saved optimizer or scheduler states exist
1. Check if continuing training from a checkpoint
1. training (use the own func named training_step)
1. Gradient clipping
1. Optimizer step
1. add remaining tr_loss

If you want to customize training steps or use your own training loops, you should use run_clm_no_tainer.py instead.

# About Dataset Loading

1. `load_dataset` func in run_clm.py (around 290 line)
1. tokenize dataset in run_clm.py (around 450 line)
1. group_text in run_clm.py (around 500 line)
   1. this is the process which is only executed in the first time.
1. split dataset into train and validation (or either)
1. `get_train_dataloader` func in trainer.py (around 1900 line)
   1. remove unused columns and return `DataLoader`

use `compute_metrics` only in evaluation steps

use input_ids, attention_masks and labels in `training_step` func in `trainer.py`.
