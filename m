Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668AC27C40
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 00:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbjHXAEM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 20:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjHXADi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 20:03:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383221A5
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692835408; x=1693440208; i=quwenruo.btrfs@gmx.com;
 bh=w4s0j7EoFkigWbdoqbvvInMMw7O3RWajCggSLLvgvnY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jCGj9jyVY8fmWuv1FAQ5QWWXVFegG+hP27rO2fjyqqXRox6xPDyvOniMekl1ELCnng1WMzr
 ybn13DXQuD+pzxEd58HEDMl1gFYP7vGyNcxAch80z0hZQTyHRP6lG3KV9iU9D4nZhZ2uwihvZ
 xUL0LDrOj+7ibuQKY9qItB/z9LU0QnQtsNdThgYKV3i9psallANxq3QcyBmU+pqeNkvkO9QCC
 Qgcyp+u3Nt/1Z5FhradSW1Pa/M0rBloO/XkINkGQ+jBufE7v0XP1ybEjvhiCHm/Hd5j1LUHrY
 FRDuUAdvDRDRUm3hhtTvd2v5XoCc1bceHpJjUQLhuZrz1D25HcMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSt8Q-1q9Cfg4BtG-00UIs7; Thu, 24
 Aug 2023 02:03:27 +0200
Message-ID: <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
Date:   Thu, 24 Aug 2023 08:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs> <ZOaFmhnUAM9gjNFv@redhat.com>
 <20230823222754.GB11251@frogsfrogsfrogs>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230823222754.GB11251@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wAdKPp88DvCAYZIvo07r0Dif7NKn+nDWtuNG2AzrAvhuyd476uS
 YQYPGnqZHVoeGO5zyy1Rm+crqC4XsjcNVm47W4AvhOB66j7+1GaeQF4DJ53MXItbSmufIoL
 NO8Mu9Pjd5uQMCkFtnll9bgR/f63i5vEmWlf+L8OvgPuBPO2JAYf5qzJoYlWi1dckjoGXiZ
 FffHRpgrEjB8IczWOPAwA==
UI-OutboundReport: notjunk:1;M01:P0:yJPDbxKdtcg=;ImYRNO/L8eVLWBem4S1nGLRlNMy
 PvNR+ZnP2G3wfhvw2CWPGFvLuiDMnui8u7DAnSQRg3SylqEi9bS6zDQiMJRpb+gTt7XUHSlzI
 OhL7fHZhKzZnWiBycmTzdKBL20MuBJ+MyIxj9G9yWoX3cbx1cG5fkYIZlyZs0WPU+FsKWVtn+
 xvWtnrZi9fuEZYs2mw9CTdnsvBYo0hyvhg/+Owjzm7qRpHXMMAF8MVHdKE7H+uKNdzEqhJgPc
 wwQAWvndh7uKlp7JFefxvlCEOYHBgw7L5EE6A4RD/pb+XnHVipAvd/e2U3Xq7xcrylFAfmDNe
 71Z2kw7xBwEKN/81hWJdmJj7EU4nGGZLWTA9BT+LC/76Y5aMZi2w3lgt5w1ANr0WDih73l8Zl
 jCQBGFWs3SNOnQpkcS4CAd6WlqGuRU6QB0DXZdO/PWdRlrXnOiKkqXipG4qCiU5/mAKqyLHye
 SeG4+deNDqd+QCbWbRqxbun/0hgslY0+sKwvOEMeYqu3UxPaVOw6AKepLIq5ibucM3qt6KVrU
 E7jWlybgWfiytfzayK4CFY7GSMuUf7PFsQD+qlOkmZrVhsyvt/oDrJqANXstmxDB0FJIh/ENV
 AbcHoXfuv/H2CukfBhkmUGcxMek9SJRJCXfCQmQF8NHtLcHMTiYbxfZitjfkBCkxkwRfzNQMM
 DGtbXvb47bUYHGLywUBOaSSTVIJz54YBeuRFb7WOr3ktNzvg5LT4B7bV7D114mPn0jhdLRSik
 Z+1A8Ch/35abzAXsE/0IybsNz/+q4XMxLR28CVjkPaog9lV6835/EY3vntlFAC9BRGJKpjLwj
 lInZQv6cRqLlzyr52CIjRg2clD3mM+n+xGZ339hKlK42sBRE2mDdyVuRIHqbqSngn2QA1fygf
 ogSu0iA2bKZs/u4rk2CFrKvgEP8OaJ2KBQWsw8I/i6VsKugk/XW4Xvwke8RMDTWZMWVmUGAFR
 CmhZeR2J5Lq9wXZ4wjGAXSkyrfs=
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2023/8/24 06:27, Darrick J. Wong wrote:
> On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
>> On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
>>> On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
>>>> xfs_io pwrite issues a series of block size writes, but there is no g=
uarantee
>>>> that the resulting extent(s) will be singular or contiguous.

However this doesn't make much difference, at least for btrfs.

Btrfs would do the merging emitting the fiemap entry, thus even if the
write didn't result a singular extent, as long as they are contiguous
(under most cases they are) the fiemap result would still be a single one.

>>>> This behavior is
>>>> acceptable, but the test is flawed in that it expects a single extent=
 for a
>>>> pwrite.

I'm more interested in if you're hitting any test failure?

>>>>
>>>> Modify test to accept any layout for the reflinked logical range.
>>>>
>>>> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
>>>> ---
>>>>   tests/generic/352     | 16 +++++++++++-----
>>>>   tests/generic/352.out |  2 --
>>>>   2 files changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tests/generic/352 b/tests/generic/352
>>>> index 52ec4850..c4ee8a44 100755
>>>> --- a/tests/generic/352
>>>> +++ b/tests/generic/352
>>>> @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _fil=
ter_xfs_io
>>>>   # use reflink to create the rest of the file, whose all extents are=
 all
>>>>   # pointing to the first extent
>>>>   for i in $(seq 1 $nr); do
>>>> -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev=
/null
>>>> +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp=
1.out
>>>
>>> $tmp1 isnt defined anywhere.
>>>
>>>>   done
>>>>
>>>>   # then call fiemap on that file to test both the shared flag and if
>>>>   # reserved extent mapping search will cause soft lockup
>>>> -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
>>>> -cat $tmp.out >> $seqres.full
>>>> +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
>>>> +cat $tmp2.out >> $seqres.full
>>>
>>> Nor is $tmp2
>>>
>>>>
>>>>   # refact the $LOAD_FACTOR to 1 to match the golden output
>>>>   sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
>>>>   	-e "s/$last_extent/$orig_last_extent/" \
>>>> -	-e "s/$end/$orig_end/" $tmp.out
>>>> -cat $tmp.out
>>>> +	-e "s/$end/$orig_end/" $tmp2.out
>>>> +
>>>> +cat $tmp1.out > tmp.1
>>>> +cat $tmp2.out > tmp.2
>>>
>>> Not sure why you didn't make the _reflink_range and the fiemap above
>>> output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
>>> default _cleanup would delete $tmp.* automatically...
>>>
>>>> +
>>>> +diff tmp.[12]
>>>> +rm tmp.1
>>>> +rm tmp.2
>>>
>>> ...and the rm here wouldn't be necessary.
>>>
>>> Ok.  Nitpicking over.  Moving on to the weirder design questions of th=
e
>>> original test:
>>>
>>> [add original test author to cc]
>>
>> Emails to quwenruo@cn.fujitsu.com seem to be undeliverable. Maybe Josep=
h
>> would know what btrfs intent was?
>
> ...or I guess I could have used the current email addr instead of the
> one on the commit. :(
>
> Qu: Question for you:

Thanks a lot for referring it to me.

>
>>> I don't know why $blocksize is set to 128k above.  If this test needs =
to
>>> guarantee that there would only be *one* extent (and the golden output
>>> implies this as you note), then it should have been written to say:
>>>
>>> 	blocksize=3D$(_get_file_block_size $SCRATCH_MNT)
>>>
>>> But I don't know if the "btrfs soft lock up and return wrong shared
>>> flag" behavior required sharing a (probably multi-block) 128k range, o=
r
>>> if that was simply what the author selected because it reproduced the
>>> problem.

It's quite sometime ago, thus my memory may not be reliable, but IIRC
the blocksize has no specific requirement other than allowing all
possible blocksize (4K to 64K).

And at that time, at least I was preferring to use golden output to
detect errors, thus I choose a larger blocksize to allow all blocksizes
to work.

>
> Any thoughts?
>
> --D
>
>>>
>>>>
>>>>   # success, all done
>>>>   status=3D0
>>>> diff --git a/tests/generic/352.out b/tests/generic/352.out
>>>> index 4ff66c21..ad90ae0d 100644
>>>> --- a/tests/generic/352.out
>>>> +++ b/tests/generic/352.out
>>>> @@ -1,5 +1,3 @@
>>>>   QA output created by 352
>>>>   wrote 131072/131072 bytes at offset 0
>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> -0: [0..2097151]: shared
>>>> -1: [2097152..2097407]: shared|last
>>>
>>> Also I suspect from the test description that the goal here was to
>>> detect the golden output failing because the shared flag does not get
>>> reported correctly.

Could explain more on why the shared flag detection is not correct here?

If a file extent is shared, no matter if it's shared by another inode or
not, shouldn't it be marked with SHARED flag?

Thanks,
Qu

>>>
>>> --D
>>>> --
>>>> 2.41.0
>>>>
>>>
>>
