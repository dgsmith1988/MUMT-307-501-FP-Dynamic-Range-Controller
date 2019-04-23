%Run this script to generate the figures used to verify the dynamic range
%controller functionality and highlight different timing issues.

disp('Press enter to see the various level detection algorithm comparisons');
pause;
levelDetectionMethodComparisons;
comparePeakToRMS;

disp('Press enter to see the threshold unit test results');
pause;
testCompressionThresholds;
testExpansionThresholds;

disp('Press enter to see the ratio unit test results');
pause;
testCompressionRatios;
testExpansionRatios;

disp('Press enter to see the knee-width unit test results');
pause;
testCompressionKnees;
testExpansionKnees;

disp('Press enter to see the attack and release time unit test results')
pause;
testPeakParameters;
testRMS2Parameters;

disp('Press enter to see the black-box threshold test results');
pause;
compressorBlackBoxTestTheshold;
compressorBlackBoxTestTheshold_v2;

disp('Press enter to see the black-box ratio test results');
pause;
compressorBlackBoxTestRatio_v2;

disp('Press enter to see the black-box knee test results');
pause;
compressorBlackBoxTestKnee;

disp('Press enter to see the "plateau" timing results');
pause;
compressorBlackBoxPlateaus;
plateauRootCause;