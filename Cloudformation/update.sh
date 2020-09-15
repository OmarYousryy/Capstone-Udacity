aws cloudformation update-stack \
--stack-name $1 \
--template-body file://$2 \
--region eu-west-1 \
--capabilities CAPABILITY_NAMED_IAM