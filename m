Received: from mail-io0-f169.google.com ([209.85.223.169]:35492 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbcF2NDd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2016 09:03:33 -0400
Received: by mail-io0-f169.google.com with SMTP id f30so44928342ioj.2
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2016 06:03:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160629125236.GM23649@eguan.usersys.redhat.com>
References: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
 <1467196693-9724-1-git-send-email-jtulak@redhat.com> <20160629125236.GM23649@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Wed, 29 Jun 2016 15:03:12 +0200
Message-ID: <CACj3i72B8PpGZtVL0z6hALhmXrEtLcTnWP8G92TwKA2h0ksjUg@mail.gmail.com>
Subject: Re: [PATCH v2] xfstests: Add mkfs input validation tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 2:52 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, Jun 29, 2016 at 12:38:13PM +0200, Jan Tulak wrote:
>> mkfs.xfs does not do a very good job of input validation. This test
>> is designed to exercise the input validation and test good/bad
>> combinations of options being set. It will not pass on an old
>> mkfs.xfs binary - it is designed to be the test case for an input
>> validation cleanup (merged in spring/summer 2016).
>>
>> Signed-off-by: Dave Chinner <dchinner@redhat.com>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>>
>> ---
>>
>> I didn't got other feedback than the three small issues fixed bellow, and it is
>> passing on current xfsprogs-dev as it should. So I think that it can be merged.
>
> Looks good to me.
>
>>
>> CHANGES:
>>   * Change copyright year to 2016
>>   * rm || true --> rm -f
>>   * Change from space to tab indent
>>
>> Cheers,
>> Jan
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>>  tests/xfs/400-input-validation     | 335 +++++++++++++++++++++++++++++++++++++
>>  tests/xfs/400-input-validation.out |   2 +
>
> Only one problem with this test seq name. Current Makefile doesn't
> support installing such test seq name
>
>   $(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
>
> Can you please send another patch to fix this?
>

O_o

Looks like I forgot the installation part when I was writing the
patches for xfstests for the extended test names. Gonna fix it!

Thanks.

Cheers,
Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
