Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32927 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbaJIQ2V convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 9 Oct 2014 12:28:21 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so67204pdb.2
        for <fstests@vger.kernel.org>; Thu, 09 Oct 2014 09:28:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] xfstests,shared/032: fix fsck failure
From: Wang Shilong <wangshilong1991@gmail.com>
In-Reply-To: <20141009162634.GJ13912@dhcp-13-216.nay.redhat.com>
Date: Fri, 10 Oct 2014 00:28:13 +0800
Content-Transfer-Encoding: 8BIT
Message-Id: <7A18E04E-812D-4237-B0A4-2B558C1EE573@gmail.com>
References: <1412900217-58174-1-git-send-email-wangshilong1991@gmail.com> <20141009162634.GJ13912@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> On Thu, Oct 09, 2014 at 08:16:57PM -0400, Wang Shilong wrote:
>> while running ./check tests/shared/032, it outputs something like:
>> 
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 vm01 3.17.0-rc5+
>> MKFS_OPTIONS  -- /dev/sdc
>> MOUNT_OPTIONS -- /dev/sdc /mnt/scratch
>> 
>> shared/032 2s ... 2s
>> _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent (see /root/xfstests-dev/results//shared/032.full)
>> Ran: shared/032
>> Passed all 1 tests
>> 
>> This is because xfstests will run fsck after each unit test,
>> for tests/shared/032, we have reformated SCRATCH_DEV to other fs,
>> fix this problem by skipping fsck here.
>> 
>> Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
>> ---
>> v2->v3: fix commit message....
> 
> I was about to point this out, and saw your v3 :)
> 
> One nitpick, the "xfstests," part in summary is not necessary to me,

Fair enough, will do it next time.


> "shared/032: ..." is good enough. Anyway,
> 
> Reviewed-by: Eryu Guan <eguan@redhat.com>
> 

Much appreciated, good night!

>> v1->v2: use _require_scratch_nocheck helper to skip fsck.(pointed by Eryu Guan)
>> ---
>> tests/shared/032 | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tests/shared/032 b/tests/shared/032
>> index 7835e30..a410003 100755
>> --- a/tests/shared/032
>> +++ b/tests/shared/032
>> @@ -40,7 +40,7 @@ rm -f $seqres.full
>> _supported_fs xfs btrfs
>> _supported_os Linux
>> 
>> -_require_scratch
>> +_require_scratch_nocheck
>> _require_no_large_scratch_dev
>> 
>> # mkfs.btrfs did not have overwrite detection at first
>> -- 
>> 1.8.3.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Best Regards,
Wang Shilong

