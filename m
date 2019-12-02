Return-Path: <SRS0=WWQL=ZY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E0C432C0
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 23:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC94020718
	for <linux-fstests@archiver.kernel.org>; Mon,  2 Dec 2019 23:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="anbDr0yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLBXVb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:21:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36266 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfLBXVb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Dec 2019 18:21:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NEBGR121973;
        Mon, 2 Dec 2019 23:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=DyjY//NAfAFR0a7JlJJAo0+G6f42HFX31NW9PDdA5+w=;
 b=anbDr0yj8PXm9TjJ0bdJZxmNxpnSuCavGhKgxksqEBMkjqBE35ty5sVavTEHRes+PwNj
 OesgmCNYoaXILnqAPDwBhJH31BUHWDa/1YHje7XGHneSJ8if2D4IBhiQqQwezkpzg/im
 ZJQburHA7um4WbhiLA6yHjUEK8K3OnQKYgTDwArmJPgRmp5ObHcg+nQkJXDey+9aZ/9r
 t0Pn/7bMAz1iYqmITlhYMU1FrTL+m8DV8RL3/cuKHGMVO8FWWFAygCNBMzGZmampPIw4
 vJ3mhqkM0yvQnOiICLpiTTwqNZ/SDje/FXtSwbO2KXckuYvUUfqX56o95Sv5TMekhZz2 Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2r3cjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 23:21:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2NE8YK131850;
        Mon, 2 Dec 2019 23:21:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wn8k1acaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 23:21:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2NLNQD002552;
        Mon, 2 Dec 2019 23:21:23 GMT
Received: from localhost (/10.159.148.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 15:21:22 -0800
Date:   Mon, 2 Dec 2019 15:21:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/148: sort and filter attribute list output
Message-ID: <20191202232121.GD7339@magnolia>
References: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020199
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 28, 2019 at 03:10:45PM +0800, Yang Xu wrote:
> When I backport fixed patches from Darrick tighten-verifiers tree, this case 

NAK, why are you backporting out of my development tree and not upstream?
What are you even backporting, seeing as the patches for this are in 5.5
and Linus hasn't even pulled that yet??

Also, why are you sending a patch to fstests that is (a) barely a week
old, (b) doesn't actually list me as the author, and (c) I myself
haven't even sent to fstests yet?

> also fails. As below:
> -----------------------------------------------------------
> "diff test/xfs/148.out result/xfs/148.out.bad
> 7,8d6
> < Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> < Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> 9a8
> > Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> 10a10,11
> > Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> > Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
> 49,50c50,51
> < Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> < heh
> > attr_get: No data available
> > Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
> -------------------------------------------------------------
> We should sort attribute list output and filter selinux. Also "a_are_bad/for_you"
> doesn't exist, we should correct it in output.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  tests/xfs/148     | 2 +-
>  tests/xfs/148.out | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/xfs/148 b/tests/xfs/148
> index 42cfdab0..06862faa 100755
> --- a/tests/xfs/148
> +++ b/tests/xfs/148
> @@ -76,7 +76,7 @@ test_names+=("too_many" "are_bad/for_you")
>  
>  access_stuff() {
>  	ls $testdir
> -	$ATTR_PROG -l $testfile
> +	$ATTR_PROG -l $testfile | grep "a_" | sort
>  
>  	for name in "${test_names[@]}"; do
>  		ls "$testdir/f_$name"
> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> index c301ecb6..ab3fc25b 100644
> --- a/tests/xfs/148.out
> +++ b/tests/xfs/148.out
> @@ -4,10 +4,10 @@ f_another
>  f_are_bad_for_you
>  f_something
>  f_too_many_beans
> +Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> +Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
>  Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>  Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> -Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
> -Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
>  TEST_DIR/mount-148/testdir/f_something
>  Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
>  heh
> @@ -46,5 +46,5 @@ ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
>  attr_get: No data available
>  Could not get "a_too_many" for TEST_DIR/mount-148/testfile
>  ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
> -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> -heh
> +attr_get: No data available
> +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile

Huh?  Why???

NAK NAK NAK

--D

> -- 
> 2.18.0
> 
> 
> 
