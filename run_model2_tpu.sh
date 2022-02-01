TASK_NAME="reu-tpu"
STORAGE_BUCKET=gs://reu_15
BERT_BASE_DIR=$STORAGE_BUCKET/biobert_v1.1_pubmed

DATA_DIR=$STORAGE_BUCKET/REU_google_cloud_biobertBP/
OUTPUT_DIR=$STORAGE_BUCKET/REU_OUTPUT/

for s in 2 4 6 8 10
	do
	for i in {1..10}
		do
			python3 run_re.py --task_name=$TASK_NAME --do_train=true --do_eval=false --do_predict=true --vocab_file=$BERT_BASE_DIR/vocab.txt --bert_config_file=$BERT_BASE_DIR/bert_config.json --init_checkpoint=$BERT_BASE_DIR/model.ckpt-1000000 --max_seq_length=512 --train_batch_size=32 --learning_rate=2e-5 --num_train_epochs=${s} --do_lower_case=false --data_dir=${DATA_DIR}${i} --output_dir=${OUTPUT_DIR}${i} --use_tpu=True --tpu_name=reu-phen


	done

	python3 ./biocodes/re_eval.py --output_path=${OUTPUT_DIR} --answer_path=${DATA_DIR} --fold_number=10 --step=${s} --task_name="reu-tpu"


done
