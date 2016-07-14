Received: from mail-io0-f169.google.com ([209.85.223.169]:34053 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcGNKUr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 06:20:47 -0400
Received: by mail-io0-f169.google.com with SMTP id q83so71537727iod.1
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 03:20:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713104641.GT2432@eguan.usersys.redhat.com>
References: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
 <1467389557-4360-1-git-send-email-jtulak@redhat.com> <20160713104641.GT2432@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 14 Jul 2016 12:20:26 +0200
Message-ID: <CACj3i7163Q3py4JK_fROwxbrcVV5-v7QsWzv-t1WvXStKwK1jQ@mail.gmail.com>
Subject: Re: [PATCH v3] xfstests: Add mkfs input validation tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 13, 2016 at 12:46 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Jul 01, 2016 at 06:12:37PM +0200, Jan Tulak wrote:
>> +
>> +# Skip if we are running an older binary without the stricter input checks.
>> +# Make multiple checks to be sure that there is no regression on the one
>> +# selected feature check, which would skew the result.
>> +$MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
>> +sum=$?
>> +$MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
>> +sum=`expr $sum + $?`
>> +
>> +if [ "$sum" -eq 0 ]; then
>> +     _notrun "Requires newer mkfs with stricter input checks."
>> +fi
>
> I think this can be put into a new _require rule in common/rc, as Dave
> suggested in his previous review:
>
> "
> ... a "_require_xfs_mkfs_validation" rule should be
> written to determine the version of mkfs being. e.g. by testing one
> of the failure cases that the unfixed binary says is ok.
> "
>

Mmm, I would say that there is a question whether any other test will
ever need it (and its author remember that there is such function),
but all right. You are two now, who says this, so I will go along.

And I think I will put everything into one patchset, because extended
names fixes has to be applied first for _notrun to work correctly,
then the common/rc functions (I'm making two - one for the new and one
for the old behaviour) and at last can come this and the xfs/096 test.

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
