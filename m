Return-Path: <SRS0=DGTx=ZZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D0C432C0
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 01:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93DE20637
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 01:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLCBqB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:46:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58023 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbfLCBqB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Dec 2019 20:46:01 -0500
X-IronPort-AV: E=Sophos;i="5.69,270,1571673600"; 
   d="scan'208";a="79481587"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Dec 2019 09:45:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 879224CE1C97;
        Tue,  3 Dec 2019 09:37:32 +0800 (CST)
Received: from [10.167.220.84] (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 3 Dec 2019 09:45:59 +0800
Subject: Re: [PATCH] xfs/148: sort and filter attribute list output
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
References: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191202232121.GD7339@magnolia>
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <297458b1-b8ad-3e88-e378-351faccc113b@cn.fujitsu.com>
Date:   Tue, 3 Dec 2019 09:45:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191202232121.GD7339@magnolia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 879224CE1C97.AC548
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



on 2019/12/03 7:21, Darrick J. Wong wrote:
> On Thu, Nov 28, 2019 at 03:10:45PM +0800, Yang Xu wrote:
>> When I backport fixed patches from Darrick tighten-verifiers tree, this case
> 
> NAK, why are you backporting out of my development tree and not upstream?
My description is wrong. I use upstream kernel 5.4-rc8 and 4 attr 
patches as your tighten-verifiers tree do.
> What are you even backporting, seeing as the patches for this are in 5.5
> and Linus hasn't even pulled that yet??
> I see Linus pulled the patches 3 hour ago,
> Also, why are you sending a patch to fstests that is (a) barely a week
> old, (b) doesn't actually list me as the author, and (c) I myself
> haven't even sent to fstests yet?
> 
I  have listed you as author,  I think I should add  "Darrick J. Wong 
pointed  selinux and sort problem" info.  I find ls and 
"a_are_bad/for_you" problem.
Also, in personal mail("Re: question about xfstests test case 
xfs/148(new)"), I said "I think you may  busy with other important 
things. I will send this simple patch with correct "a_are_bad/for_you" 
info and add your signed-off-by tag."). Anyway, I am sorry, I should 
have received your reply before sending the patch.
>> also fails. As below:
>> -----------------------------------------------------------
>> "diff test/xfs/148.out result/xfs/148.out.bad
>> 7,8d6
>> < Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>> < Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
>> 9a8
>>> Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
>> 10a10,11
>>> Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>>> Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
>> 49,50c50,51
>> < Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
>> < heh
>>> attr_get: No data available
>>> Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
>> -------------------------------------------------------------
>> We should sort attribute list output and filter selinux. Also "a_are_bad/for_you"
>> doesn't exist, we should correct it in output.
>>
>> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
...
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/148     | 2 +-
>>   tests/xfs/148.out | 8 ++++----
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/xfs/148 b/tests/xfs/148
>> index 42cfdab0..06862faa 100755
>> --- a/tests/xfs/148
>> +++ b/tests/xfs/148
>> @@ -76,7 +76,7 @@ test_names+=("too_many" "are_bad/for_you")
>>   
>>   access_stuff() {
>>   	ls $testdir
>> -	$ATTR_PROG -l $testfile
>> +	$ATTR_PROG -l $testfile | grep "a_" | sort
>>   
>>   	for name in "${test_names[@]}"; do
>>   		ls "$testdir/f_$name"
>> diff --git a/tests/xfs/148.out b/tests/xfs/148.out
>> index c301ecb6..ab3fc25b 100644
>> --- a/tests/xfs/148.out
>> +++ b/tests/xfs/148.out
>> @@ -4,10 +4,10 @@ f_another
>>   f_are_bad_for_you
>>   f_something
>>   f_too_many_beans
>> +Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
>> +Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
>>   Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
>>   Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
>> -Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
>> -Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
>>   TEST_DIR/mount-148/testdir/f_something
>>   Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
>>   heh
>> @@ -46,5 +46,5 @@ ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
>>   attr_get: No data available
>>   Could not get "a_too_many" for TEST_DIR/mount-148/testfile
>>   ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
>> -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
>> -heh
>> +attr_get: No data available
>> +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
> 
> Huh?  Why???
> 
> NAK NAK NAK
a_are_bad_for_you has been corrupted by "/". So it should be nothing 
such as  a_too_many_beans by beans. am  I wrong?( I use 5.4-rc8 and 4 
patches
xfs: check attribute leaf block structure
xfs: namecheck attribute names before listing them
xfs: namecheck directory entry names before listing them
xfs: replace -EIO with -EFSCORRUPTED for corrupt metadata
,this four patches from 
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=tighten-verifiers
)>
> 
> --D
> 
>> -- 
>> 2.18.0
>>
>>
>>
> 
> 


