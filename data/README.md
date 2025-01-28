# Data

Save raw data files here.

Note: raw data files saved in scratch directory to save space

## Additional information about downloading from Google Cloud. 

These files were downloaded from Google Cloud by Christina Azodi on 9 Nov 2022. Only the 10 tissues with the largest samples sizes for eQTL mapping were downloaded.

This required setting up a cloud storage bucket (tmp_gtex_download), note to set this up switch "fine grained" instead of "uniform" access controls. Then manually adding the "Storage admin" user permission. After setting up this configuration, in cloudshell:

```
gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Adipose_Subcutaneous.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Muscle_Skeletal.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Whole_Blood.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Skin_Sun_Exposed_Lower_leg.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Artery_Tibial.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Thyroid.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Nerve_Tibial.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Skin_Not_Sun_Exposed_Suprapubic.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Lung.allpairs.txt.gz gs://tmp_gtex_download/

gsutil -u 880544914449 cp gs://gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations/Esophagus_Mucosa.allpairs.txt.gz gs://tmp_gtex_download/
```

To transfer these to the server, I used gsutil from conda.


