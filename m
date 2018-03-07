Received: from mail-ua0-f195.google.com ([209.85.217.195]:41456 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933280AbeCGNHs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Mar 2018 08:07:48 -0500
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20180307070747.GG30836@localhost.localdomain>
References: <20180306070231.16880-1-lufq.fnst@cn.fujitsu.com> <20180307070747.GG30836@localhost.localdomain>
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 7 Mar 2018 13:07:46 +0000
Message-ID: <CAL3q7H4XkGUnEx4jw0QkvnpoUTHesW83691pi+3ZGDMCDooqSQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/004: increase the buffer size of
 logical-resolve to the maximum value 64K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Lu Fengqi <lufq.fnst@cn.fujitsu.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 7, 2018 at 7:07 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> On Tue, Mar 06, 2018 at 03:02:31PM +0800, Lu Fengqi wrote:
>> Because of commit e76e13ce8c0b ("fsstress: implement the
>> clonerange/deduperange ioctls"), dedupe makes the number of references t=
o
>> the same extent item increase so much that the default 4K buffer of
>> logical-resolve is no longer sufficient.
>>
>> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
>
> This looks fine to me. But I'd like an explicit ack from btrfs
> developers.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me.

>
> Thanks,
> Eryu
>
>> ---
>>  tests/btrfs/004 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/004 b/tests/btrfs/004
>> index de583cc355d4..0d2efb91dba7 100755
>> --- a/tests/btrfs/004
>> +++ b/tests/btrfs/004
>> @@ -103,7 +103,7 @@ _btrfs_inspect_addr()
>>       expect_addr=3D$3
>>       expect_inum=3D$4
>>       file=3D$5
>> -     cmd=3D"$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $addr =
$mp"
>> +     cmd=3D"$BTRFS_UTIL_PROG inspect-internal logical-resolve -s 65536 =
-P $addr $mp"
>>       echo "# $cmd" >> $seqres.full
>>       out=3D`$cmd`
>>       echo "$out" >> $seqres.full
>> --
>> 2.16.2
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
