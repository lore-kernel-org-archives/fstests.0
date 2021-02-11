Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D86C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606D964EBB
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBKDcl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:32:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhBKDck (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 22:32:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B38Wgl040467;
        Wed, 10 Feb 2021 22:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8zaP9w/LjqJzzZh7U+uwvvIvRoXQ8JsfXNUVsCao3nE=;
 b=b7+jkPxzxYFTgGUh4laZCB7DMblkjAHNFDLf9ewyLfqo4tvb1CH1UTeqS7yEGvugWwMV
 kxEklYWfb6PoWfmvKKpgknVli0ii4S26ITIkjJd9Wy8qiG8nZaWD7lEUb7w4GvTFQj3x
 cg+HPq2X70eBiuAG5CbW/2mat36humPvsHZngK02lQ5xdUrxDDV2vemQytuL7nanlQBb
 j6oqjCEIVCs0E9BvcyjE6LFCD7L7cXsAHJyEokDMmkyWwKAT87AAgG4yt6mtPvD6VQcF
 3hFhF08tDf7e3O6VZOU1fBAo94g5duTH6ABlHI9Sn4SnudJ8MsvsGRu9CNPrWHPmxeUH Dg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mv1c8qr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 22:31:57 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B3TGfO008981;
        Thu, 11 Feb 2021 03:31:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 36hjr8asyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 03:31:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B3VqAe47186178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 03:31:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B4CA4055;
        Thu, 11 Feb 2021 03:31:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9EE4A4040;
        Thu, 11 Feb 2021 03:31:51 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.35.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 03:31:51 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 1/3] check: add CLI option to repeat and stop tests in case of failure
Date:   Thu, 11 Feb 2021 09:01:44 +0530
Message-Id: <4e3a0b44ed39e7a60457c46801630f610b44e308.1612951443.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612951443.git.riteshh@linux.ibm.com>
References: <cover.1612951443.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_11:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=647 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110016
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently with -i <n> option the test can run for many iterations,
but in case if we want to stop the iteration in case of a failure,
it is much easier to have such an option which could check the failed
status and stop the test from further proceeding.

This patch adds such an option (-I <n>) thereby extending the -i <n> option
functionality.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 check | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/check b/check
index c6ad1d6c0733..6760d066955d 100755
--- a/check
+++ b/check
@@ -27,6 +27,7 @@ brief_test_summary=false
 do_report=false
 DUMP_OUTPUT=false
 iterations=1
+istop=false

 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -68,6 +69,7 @@ check options
     -T			output timestamps
     -r			randomize test order
     -i <n>		iterate the test list <n> times
+    -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
     -d			dump test output to stdout
     -b			brief test summary
     -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
@@ -300,6 +302,7 @@ while [ $# -gt 0 ]; do
 	-n)	showme=true ;;
         -r)	randomize=true ;;
 	-i)	iterations=$2; shift ;;
+	-I) 	iterations=$2; istop=true; shift ;;
 	-T)	timestamp=true ;;
 	-d)	DUMP_OUTPUT=true ;;
 	-b)	brief_test_summary=true;;
@@ -926,6 +929,11 @@ function run_section()
 for ((iters = 0; iters < $iterations; iters++)) do
 	for section in $HOST_OPTIONS_SECTIONS; do
 		run_section $section
+		if [ "$sum_bad" != 0 ] && [ "$istop" = true ]; then
+			interrupt=false
+			status=`expr $sum_bad != 0`
+			exit
+		fi
 	done
 done

--
