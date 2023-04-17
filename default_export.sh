#!/usr/bin/env bash

rm -r $HOME/onnx/sql-summarize/codet5-base-sql
python export_onnx.py SEBIS/code_trans_t5_base_source_code_summarization_sql $HOME/onnx/sql-summarize/codet5-base-sql
rm -r $HOME/onnx/doc-gen/codet5-base-javascript
python export_onnx.py SEBIS/code_trans_t5_base_code_documentation_generation_javascript_transfer_learning_finetune $HOME/onnx/doc-gen/codet5-base-javascript
rm -r $HOME/onnx/commit-gen/codet5-base-commit
python export_onnx.py SEBIS/code_trans_t5_base_commit_generation_multitask_finetune $HOME/onnx/commit-gen/codet5-base-commit
