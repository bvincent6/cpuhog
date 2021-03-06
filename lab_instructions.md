### Procedure

1. Clone repository to linux environment with `oc` available

2. Change working directory to `cpuhog`

3. Examine `template-cpuhog.yml` and note the resources defined within it
  * Deployment
  * Service
  * HorizontalPodAutoscaler
  * Route
  * ConfigMap

4. Run `oc process -f template-cpuhog.yml` and examine the output.

5. Run `oc process -f template-cpuhog.yml | oc apply -f -`

5. Run `oc get all` multiple times, observing the output until all pods ar running and ready

6. Run `oc get route`. Note the URL under the route called "cpuhog".

7. Run `curl <url>/calc` where "<url>" is the URL noted in step 6. If a JSON object is returned, the app and route are up and running.

8. Run `./test.sh 8 32 <url>` where "<url>" is the URL noted in step 6.

9. Navigate to the OpenShift Console and log in with your credentials.

10. Navigate to the "Workloads" tab on the left side of the UI, then click on HorizontalPodAutoscalers.

11. Towards the top of the screen, ensure that the project you have been working in is selected form the drop-down list.

12. Click on the "cpuhog" Horizontal Pod Scaler (HPA).

13. Click on the "Events" tab from the HPA screen.

14. Wait to observe auto-scaling events generated by `test.sh`