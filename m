Return-Path: <SRS0=+Qx+=Z2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F7C43603
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Dec 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B3205ED
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Dec 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0+yCxRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDQK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:10:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDQK7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Dec 2019 11:10:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4G4IJM141294;
        Wed, 4 Dec 2019 16:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BvB4AHafBcZEq9+/Bpw88yflLqjg32/562t+7q1DetE=;
 b=G0+yCxRk8/11U1lZ8LNP2H9p63/cMjlmSw9fwYbYsbR46V/YZBtnOLvDmH2CtPYz/KqQ
 M6DAsDzRwIoAsG4TZzfr6JYbgLRfJ2iMQvvjzRe6wEjQtmFpfeblF5pc0NySfCC0ivCR
 USBvYaBht6SNFP+xY2D5TG4fnymo++CJsppArPxZbEHsTcoQ1q55OVRh/JbIjZu8rBhP
 csmVaJa4XAYP/e4Ml3TaAbm6eaNyAc1I3STnnTzADPxXLfrFBCaWkNk4/aFmpH2LXXlo
 qFOiFQtCoZnAXCd2mEMnKAo/Xib8A7k/hROrjj3fVqVklqbuBE8CpLBw7OMUs+l+zDW2 CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2rf93k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 16:10:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4G4Asw050791;
        Wed, 4 Dec 2019 16:10:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wnvr03nhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 16:10:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4GAr2d010475;
        Wed, 4 Dec 2019 16:10:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 08:10:53 -0800
Date:   Wed, 4 Dec 2019 08:10:53 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] xfs/148: fix some errors for output
Message-ID: <20191204161053.GF7328@magnolia>
References: <20191204080423.27295-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204080423.27295-1-xifeng@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040134
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 04, 2019 at 04:04:23PM +0800, XiaoLi Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> When disable crc, the extended attributes display is different for
> "attr -l". And there is no quotes when ls no-exist file in RHEL7. eg.
> RHEL7:
> ls: cannot access file: No such file or directory
> RHEL8:
> ls: cannot access 'file': No such file or directory
> 
> Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> ---
>  tests/xfs/148     |  2 +-
>  tests/xfs/148.out | 17 +++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/xfs/148 b/tests/xfs/148
> index 42cfdab0..1203edd9 100755
> --- a/tests/xfs/148
> +++ b/tests/xfs/148
> @@ -79,7 +79,7 @@ access_stuff() {
>  	$ATTR_PROG -l $testfile
>  
>  	for name in "${test_names[@]}"; do
> -		ls "$testdir/f_$name"
> +		ls "$testdir/f_$name" 2>&1 | sed -e "s/'//g"
>  		$ATTR_PROG -g "a_$name" $testfile
>  	done
>  }
> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> index c301ecb6..b1bea98a 100644
> --- a/tests/xfs/148.out
> +++ b/tests/xfs/148.out
> @@ -4,10 +4,11 @@ f_another
>  f_are_bad_for_you
>  f_something
>  f_too_many_beans
> -Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> -Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
>  Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
> +Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
>  Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> +Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> +Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile

The single-quot filter part is fine, but this change in the golden
output doesn't reflect that...

--D

>  TEST_DIR/mount-148/testdir/f_something
>  Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> @@ -20,10 +21,10 @@ heh
>  TEST_DIR/mount-148/testdir/f_another
>  Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or directory
>  attr_get: No data available
>  Could not get "a_too_many" for TEST_DIR/mount-148/testfile
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such file or directory
>  attr_get: No data available
>  Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
>  ++ ACCESSING BAD METADATA
> @@ -33,18 +34,18 @@ attr_list: Structure needs cleaning
>  TEST_DIR/mount-148/testdir/f_something
>  Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many_beans': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many_beans: No such file or directory
>  attr_get: No data available
>  Could not get "a_too_many_beans" for TEST_DIR/mount-148/testfile
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad_for_you': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad_for_you: No such file or directory
>  attr_get: No data available
>  Could not get "a_are_bad_for_you" for TEST_DIR/mount-148/testfile
>  TEST_DIR/mount-148/testdir/f_another
>  Attribute "a_another" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_too_many: No such file or directory
>  attr_get: No data available
>  Could not get "a_too_many" for TEST_DIR/mount-148/testfile
> -ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
> +ls: cannot access TEST_DIR/mount-148/testdir/f_are_bad/for_you: No such file or directory
>  Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> -- 
> 2.18.1
> 
