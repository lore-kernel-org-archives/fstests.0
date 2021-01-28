Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679FC433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 08:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5D964DCE
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 08:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhA1Iur (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Jan 2021 03:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231906AbhA1ItQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Jan 2021 03:49:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S8VYoW083168;
        Thu, 28 Jan 2021 03:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uodZcCq+Y7yH14Vrqchnx4qP7LUtSliqpynnFVqRd4Y=;
 b=pAaKYkeOO21OUDRArxmbOm5cqa+w4U3gT4586ethudr6T5V4oo93r4PWqAgIoIDTCUo1
 heLs32HNWQfCT5hht5ZGu7+DUPLExJku3+jzkZo+Ao0DDMA7A0puOCZVbQSZ/QcECyxf
 DQVjOGP+l4VnuIvld8TvwLPrqebxj2U4A6VV3IjN2qtC5q2H343fgwon3d7WFB0gIKbW
 Px2VqLhMEE724ZRFzcbX+1TVJOXSaJmBmjNlM2hBZtlkhuAqJjFiC4YLNLndLvZee7m4
 nJ97UUOdjMbB2v6aOlLlLLtXiPY47TIDxftKwYreM8IYDf3F2PslkOFSupPJUcBZdWHQ Xw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36bqst40eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 03:49:48 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S8h2NX011102;
        Thu, 28 Jan 2021 08:49:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 368be7vmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 08:49:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S8ni9i46137850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 08:49:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75922AE056;
        Thu, 28 Jan 2021 08:49:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B005AE045;
        Thu, 28 Jan 2021 08:49:43 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.44.49])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jan 2021 08:49:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH ] check: add CLI option to repeat and stop tests in case of failure
Date:   Thu, 28 Jan 2021 14:19:41 +0530
Message-Id: <56a687e167af434fa54429558164ff7fee32c67d.1611823132.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_02:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=668 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280039
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently with -i <n> option the test can run for many iterations,
but in case if we want to stop the iteration in case of a failure,
it is much easier to have such an option which could check the failed
status and stop the test from further proceeding.

This patch adds such an option thereby extending the -i <n> option
functionality.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 check | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check b/check
index c6ad1d6c0733..6f3a5d47e212 100755
--- a/check
+++ b/check
@@ -15,6 +15,7 @@ sum_bad=0
 bad=""
 n_notrun=0
 notrun=""
+tc_status=""
 interrupt=true
 diff="diff -u"
 showme=false
@@ -27,6 +28,7 @@ brief_test_summary=false
 do_report=false
 DUMP_OUTPUT=false
 iterations=1
+istop=false

 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -68,6 +70,7 @@ check options
     -T			output timestamps
     -r			randomize test order
     -i <n>		iterate the test list <n> times
+    -istop <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
     -d			dump test output to stdout
     -b			brief test summary
     -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
@@ -300,6 +303,7 @@ while [ $# -gt 0 ]; do
 	-n)	showme=true ;;
         -r)	randomize=true ;;
 	-i)	iterations=$2; shift ;;
+	-istop) iterations=$2; istop=true; shift ;;
 	-T)	timestamp=true ;;
 	-d)	DUMP_OUTPUT=true ;;
 	-b)	brief_test_summary=true;;
@@ -926,6 +930,11 @@ function run_section()
 for ((iters = 0; iters < $iterations; iters++)) do
 	for section in $HOST_OPTIONS_SECTIONS; do
 		run_section $section
+		if [ "$tc_status" = "fail" ] && [ "$istop" = true ]; then
+			interrupt=false
+			status=`expr $sum_bad != 0`
+			exit
+		fi
 	done
 done

--
2.26.2

