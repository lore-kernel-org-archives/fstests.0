Return-Path: <SRS0=++Hp=ZV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CEFC432C0
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Nov 2019 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C503B215F1
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Nov 2019 09:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfK2Jsn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:48:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55345 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbfK2Jsn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Nov 2019 04:48:43 -0500
X-IronPort-AV: E=Sophos;i="5.69,257,1571673600"; 
   d="scan'208";a="79274362"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Nov 2019 17:48:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 723304CE1C09;
        Fri, 29 Nov 2019 17:40:13 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 29 Nov 2019 17:48:39 +0800
Subject: Re: [PATCH] xfs/148: sort and filter attribute list output
To:     <fstests@vger.kernel.org>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <830da627-d5ab-6e76-297c-8425506420d7@cn.fujitsu.com>
Date:   Fri, 29 Nov 2019 17:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 723304CE1C09.AA7C7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/11/28 15:10, Yang Xu wrote:
> When I backport fixed patches from Darrick tighten-verifiers tree, this case
> also fails. As below:
> -----------------------------------------------------------
> "diff test/xfs/148.out result/xfs/148.out.bad
> 7,8d6
> < Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> < Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> 9a8
>> Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> 10a10,11
>> Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>> Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
> 49,50c50,51
> < Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> < heh
>> attr_get: No data available
>> Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
> -------------------------------------------------------------
> We should sort attribute list output and filter selinux. Also "a_are_bad/for_you"
> doesn't exist, we should correct it in output.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   tests/xfs/148     | 2 +-
>   tests/xfs/148.out | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/xfs/148 b/tests/xfs/148
> index 42cfdab0..06862faa 100755
> --- a/tests/xfs/148
> +++ b/tests/xfs/148
> @@ -76,7 +76,7 @@ test_names+=("too_many" "are_bad/for_you")
>   
>   access_stuff() {
>   	ls $testdir
> -	$ATTR_PROG -l $testfile
> +	$ATTR_PROG -l $testfile | grep "a_" | sort
>   
>   	for name in "${test_names[@]}"; do
>   		ls "$testdir/f_$name"
on  3.10.0-1101.el7.x86_64 kernel,
#ls -l TEST_DIR/mount-148/testfile
#ls: cannot access TEST_DIR/mount-148/testfile: No such file or directory

on 4.18.0-147.el8.x86_64
# ls -l TEST_DIR/mount-148/testfile
#ls: cannot access 'TEST_DIR/mount-148/testfile': No such file or directory
[root@localhost ltp]#

I think we should filter "'" by sed and change 148.out. I will send v2 
patch.


> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
> index c301ecb6..ab3fc25b 100644
> --- a/tests/xfs/148.out
> +++ b/tests/xfs/148.out
> @@ -4,10 +4,10 @@ f_another
>   f_are_bad_for_you
>   f_something
>   f_too_many_beans
> +Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
> +Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
>   Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>   Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
> -Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
> -Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
>   TEST_DIR/mount-148/testdir/f_something
>   Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
>   heh
> @@ -46,5 +46,5 @@ ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
>   attr_get: No data available
>   Could not get "a_too_many" for TEST_DIR/mount-148/testfile
>   ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
> -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
> -heh
> +attr_get: No data available
> +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> 


