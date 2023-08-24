Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D974AC71145
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 06:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjHXGrP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Aug 2023 02:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjHXGqc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Aug 2023 02:46:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C769198
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 23:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692859574; x=1693464374; i=quwenruo.btrfs@gmx.com;
 bh=UDwvoD3+B99Ae+qYB5nhXUDNT+xo+OrUzBhPJwqrUEI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UWkMFAI1Ipi8W3PaUOM6csbfC8fGy3wuhQ6hHJkHnuYLv7DlEADhCWO2MmigJ3ZkVVnrFdP
 E4wUpXJ8mKm00CKQMabKS2fI9azlIV5GXbtHXUhYHtMa8LCJViThJdu1jow6eJpJssBFWTQni
 RbmRk6l+9hE+2lQA/8sXltYUVqw/FGG3lZ05fxouRI/Lge0LinNICpB/55baYDO/1fjw3H7Zl
 tMnyB6jZAOaTUV4xpRdw5NDO0mlT2skSDTNPyr1sDohi4WmpHYNMj3RLdP3g4QusVao85BU5E
 zwwBHw9qLCb5pGt+UU32GLEP/d4lLiVATR6ou2yRIM8l0lMy4NYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1q4vYA2g07-00htMQ; Thu, 24
 Aug 2023 08:46:14 +0200
Message-ID: <1b1ae25f-518f-4614-89d1-8fd564d82678@gmx.com>
Date:   Thu, 24 Aug 2023 14:46:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Content-Language: en-US
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs> <ZOaFmhnUAM9gjNFv@redhat.com>
 <20230823222754.GB11251@frogsfrogsfrogs>
 <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com> <ZObQw4amc3D60RSr@redhat.com>
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
In-Reply-To: <ZObQw4amc3D60RSr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aCGT0QYSKNIKjtOOQZt0NQy4h5UOC6SENbWaVk+Ykx0KpZRhC2c
 H1od9l5u/sqtNZ3Q4pS1feOkMhqk49tsK8I6MdulaWcGRAd9ol454RkLKJ3mlBGV3C1lDpU
 zf+oF9EvhGMQf4V7CfxIkjbvM6FII31C7CF/QLtH5rKseA/Lju3BTJaKmvdjB7BJrYgTFoi
 1/fllE7Sfoiv9CtYJJYYg==
UI-OutboundReport: notjunk:1;M01:P0:5uNJiffg4mE=;M7+hctc2p/hMzXOVCgbUghUxhh/
 a9GKbdmcNqSUDnTqcVid3Y1eE6OGRx3hFBpI2fQH3Sv+lspqA7wAre1tWp9eZPqO0uYpWCCxh
 W2U4bezIfraclXFvacwNaIsjv3gxC2LjOYrXas8hQNiG/6J2xuqd5kNdCqq6wl31J9A5LB+Fk
 bnz8fNSFgjdnQycq0OvexjvXAUuhZQhYwKWvWAgp+bTOj0cTOS621rwyxtSoNElVf2zCwDZzj
 OSgHLpjkpvRU5ujLrpouEEcxXX1VpZn28YNEg5OOT6EivYiGvjeELRIwJUhyfci2JaUkaDwPq
 o+xuSm0KXMPDjmK6se8OGfd7tZBHTda5LYK9uzKhZVWFqpCU5BTzDCEMX03Cp4+D48iiREWrL
 ynP89qqs2NkEfQlc1wDTYje7rXbtRaR75qbxGJwlWAS15L4CeEyy4RFBB9WtFhx2dzZKdEfQE
 xUSQgTS8q2OwSnw+icduOO8AiKeedWNtqJUE0DAKbXC0o+c6N3aPYBFoUrD6FXJEDWWKNwKj+
 ZGunXPbk4rxyPN+RYXcqpTn98Q4kluSdKzDznmR2rRb2+tC39afR2ia7m9QZ+nlsNvscEdfjK
 RhSwzY+11yEMGfmQhjQmDmpI7jiDSIJ4YnT5j8obw6HDtsyW+MMJA88Q+cTghqzDdYs5/v2rb
 HplOzLuaR7ufh/2s/0iqDYO3CVDiV9v3+rS5TvJTYduCrsb15LfKOvxd42W4rwwLV7RWpiwxM
 nqUpzmsVLIOUby+UfhvcGqkJeFwGuavTy/0nfskEIVUcRZKUb0WLjy2phwSMuYQdoijMJrA5k
 BEMbcr93gEwfboE5U8ukp7ThzgT72JwW12UWfqevVBwfr7+osIdBEAMVhEgOhWBjIiDoun4gV
 eATA7fvh0i7QGU1xSHrCTa4yFoU3tZ4nDyD+OinKBhMZ7AEDRGYili45UTzon7Y/LM6GSkTv4
 Ss3KQEq/1kUIroIvfKoMOHl45Aw=
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2023/8/24 11:38, Bill O'Donnell wrote:
> On Thu, Aug 24, 2023 at 08:03:23AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/8/24 06:27, Darrick J. Wong wrote:
>>> On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
>>>> On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
>>>>> On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
>>>>>> xfs_io pwrite issues a series of block size writes, but there is no=
 guarantee
>>>>>> that the resulting extent(s) will be singular or contiguous.
>>
>> However this doesn't make much difference, at least for btrfs.
>>
>> Btrfs would do the merging emitting the fiemap entry, thus even if the
>> write didn't result a singular extent, as long as they are contiguous
>> (under most cases they are) the fiemap result would still be a single o=
ne.
>>
>>>>>> This behavior is
>>>>>> acceptable, but the test is flawed in that it expects a single exte=
nt for a
>>>>>> pwrite.
>>
>> I'm more interested in if you're hitting any test failure?
>
> Yes we are.

I guess it's using XFS?

Then the idea of using proper block size looks good to me.

And since we're getting rid of the golden output, it's also a good
timing to get rid of the refactoring to match the golden output completely=
.

Thanks,
Qu
>
> thanks-
> Bill
>
>
>>
>>>>>>
>>>>>> Modify test to accept any layout for the reflinked logical range.
>>>>>>
>>>>>> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
>>>>>> ---
>>>>>>    tests/generic/352     | 16 +++++++++++-----
>>>>>>    tests/generic/352.out |  2 --
>>>>>>    2 files changed, 11 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/tests/generic/352 b/tests/generic/352
>>>>>> index 52ec4850..c4ee8a44 100755
>>>>>> --- a/tests/generic/352
>>>>>> +++ b/tests/generic/352
>>>>>> @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _f=
ilter_xfs_io
>>>>>>    # use reflink to create the rest of the file, whose all extents =
are all
>>>>>>    # pointing to the first extent
>>>>>>    for i in $(seq 1 $nr); do
>>>>>> -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /d=
ev/null
>>>>>> +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $t=
mp1.out
>>>>>
>>>>> $tmp1 isnt defined anywhere.
>>>>>
>>>>>>    done
>>>>>>
>>>>>>    # then call fiemap on that file to test both the shared flag and=
 if
>>>>>>    # reserved extent mapping search will cause soft lockup
>>>>>> -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.ou=
t
>>>>>> -cat $tmp.out >> $seqres.full
>>>>>> +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.o=
ut
>>>>>> +cat $tmp2.out >> $seqres.full
>>>>>
>>>>> Nor is $tmp2
>>>>>
>>>>>>
>>>>>>    # refact the $LOAD_FACTOR to 1 to match the golden output
>>>>>>    sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" =
\
>>>>>>    	-e "s/$last_extent/$orig_last_extent/" \
>>>>>> -	-e "s/$end/$orig_end/" $tmp.out
>>>>>> -cat $tmp.out
>>>>>> +	-e "s/$end/$orig_end/" $tmp2.out
>>>>>> +
>>>>>> +cat $tmp1.out > tmp.1
>>>>>> +cat $tmp2.out > tmp.2
>>>>>
>>>>> Not sure why you didn't make the _reflink_range and the fiemap above
>>>>> output to $tmp.out1 and $tmp.out2, respectively.  If you had, then t=
he
>>>>> default _cleanup would delete $tmp.* automatically...
>>>>>
>>>>>> +
>>>>>> +diff tmp.[12]
>>>>>> +rm tmp.1
>>>>>> +rm tmp.2
>>>>>
>>>>> ...and the rm here wouldn't be necessary.
>>>>>
>>>>> Ok.  Nitpicking over.  Moving on to the weirder design questions of =
the
>>>>> original test:
>>>>>
>>>>> [add original test author to cc]
>>>>
>>>> Emails to quwenruo@cn.fujitsu.com seem to be undeliverable. Maybe Jos=
eph
>>>> would know what btrfs intent was?
>>>
>>> ...or I guess I could have used the current email addr instead of the
>>> one on the commit. :(
>>>
>>> Qu: Question for you:
>>
>> Thanks a lot for referring it to me.
>>
>>>
>>>>> I don't know why $blocksize is set to 128k above.  If this test need=
s to
>>>>> guarantee that there would only be *one* extent (and the golden outp=
ut
>>>>> implies this as you note), then it should have been written to say:
>>>>>
>>>>> 	blocksize=3D$(_get_file_block_size $SCRATCH_MNT)
>>>>>
>>>>> But I don't know if the "btrfs soft lock up and return wrong shared
>>>>> flag" behavior required sharing a (probably multi-block) 128k range,=
 or
>>>>> if that was simply what the author selected because it reproduced th=
e
>>>>> problem.
>>
>> It's quite sometime ago, thus my memory may not be reliable, but IIRC
>> the blocksize has no specific requirement other than allowing all
>> possible blocksize (4K to 64K).
>>
>> And at that time, at least I was preferring to use golden output to
>> detect errors, thus I choose a larger blocksize to allow all blocksizes
>> to work.
>>
>>>
>>> Any thoughts?
>>>
>>> --D
>>>
>>>>>
>>>>>>
>>>>>>    # success, all done
>>>>>>    status=3D0
>>>>>> diff --git a/tests/generic/352.out b/tests/generic/352.out
>>>>>> index 4ff66c21..ad90ae0d 100644
>>>>>> --- a/tests/generic/352.out
>>>>>> +++ b/tests/generic/352.out
>>>>>> @@ -1,5 +1,3 @@
>>>>>>    QA output created by 352
>>>>>>    wrote 131072/131072 bytes at offset 0
>>>>>>    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>>> -0: [0..2097151]: shared
>>>>>> -1: [2097152..2097407]: shared|last
>>>>>
>>>>> Also I suspect from the test description that the goal here was to
>>>>> detect the golden output failing because the shared flag does not ge=
t
>>>>> reported correctly.
>>
>> Could explain more on why the shared flag detection is not correct here=
?
>>
>> If a file extent is shared, no matter if it's shared by another inode o=
r
>> not, shouldn't it be marked with SHARED flag?
>>
>> Thanks,
>> Qu
>>
>>>>>
>>>>> --D
>>>>>> --
>>>>>> 2.41.0
>>>>>>
>>>>>
>>>>
>>
>
