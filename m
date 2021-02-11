Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D369C433E9
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373AC64EBB
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Feb 2021 03:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBKDcn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:32:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229583AbhBKDcl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 22:32:41 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B3N2Je039034;
        Wed, 10 Feb 2021 22:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=47g7px49hFJzZLpEcexvwD48CsL8aW5CvkVkrBZeQp8=;
 b=f9tNVZdqcvDIFyVuhWnjDfrbXrjmhG5RmxYCyD7gH3YTijyNqC9XJgPQesTO2qh1CfdF
 LlYnFd0LJ3vC+zA88xXlJEju7ihpfLf2Uy4caH9T1+zFfUuuj13vE+7ULvZIIlzkK6pV
 etdUwLPRSzJiEsoltFCaV69xZuAprs54qgXNVm7KStkgEBYEULjae3T+khwnXsMWkX6Z
 FHZHMR5ME1LA00n5L3ZX218AaPGDwlTlBBjpxd6fVSC5SOG6Bk5EU1/Lf9RU8ZMdWcFn
 RDsJUesP2VoWAXOHhhCdMEN5McV7XBpMUp4LUE3cQOhHp+a+leYOFfkXHtIS7/bc2g9o YQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36mvmkr4d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 22:31:57 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B3UPcs021104;
        Thu, 11 Feb 2021 03:31:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 36hjr7tssv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 03:31:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B3VrMT19595602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 03:31:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC1DCA4051;
        Thu, 11 Feb 2021 03:31:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E94C5A4040;
        Thu, 11 Feb 2021 03:31:52 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.35.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 03:31:52 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/3] common/rc: Add _require_get_hugepagesize and fix _require_label_get_max
Date:   Thu, 11 Feb 2021 09:01:45 +0530
Message-Id: <05dbc4b37d77e03bc288feb07815f737efbf2abd.1612951443.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612951443.git.riteshh@linux.ibm.com>
References: <cover.1612951443.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_02:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110021
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_notrun executed from a subshell $(cmd) won't exit it's parent.
Hence _require_*** functions shouldn't have below statements.
	dummy=$(_label_get_max)
Also add a function _require_get_hugepagesize(), since it seems the
intention of _get_hugepagesize() is to also '_notrun' when the hugepagesize
is not a valid number.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 649b1cfd884a..1831714198af 100644
--- a/common/rc
+++ b/common/rc
@@ -175,6 +175,12 @@ _get_hugepagesize()
 	echo $((hugepgsz * 1024))
 }

+_require_get_hugepagesize()
+{
+	# Just a dummy for _notrun if hugepagesize is not supported
+	_get_hugepagesize
+}
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
@@ -4250,7 +4256,7 @@ _label_get_max()
 _require_label_get_max()
 {
 	# Just call _label_get_max which will notrun if appropriate
-	dummy=$(_label_get_max)
+	_label_get_max
 }

 _dmsetup_remove()
--

