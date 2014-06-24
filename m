Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45176 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaFXIk7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Jun 2014 04:40:59 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so6102698lbv.14
        for <fstests@vger.kernel.org>; Tue, 24 Jun 2014 01:40:57 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20140624043835.GF9508@dastard>
References: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
	<1403535255-14601-2-git-send-email-lczerner@redhat.com>
	<20140624043835.GF9508@dastard>
Date: Tue, 24 Jun 2014 09:40:57 +0100
Message-ID: <CAL3q7H4074PC+jJGxT-Bp0Et2HetFb5LX+swiyqnL+smFMR2gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic/017: Do not create file systems with
 different block sizes
From: Filipe David Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: xfstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Lukas Czerner <lczerner@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 24, 2014 at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
> On Mon, Jun 23, 2014 at 04:54:15PM +0200, Lukas Czerner wrote:
>> User takes care about specifying mkfs options he wishes to test and the
>> test itself should not change it if it's not strictly necessary for the
>> test itself.
>>
>> In this case it is not necessary and we should only test configuration
>> provided by the user. Moreover if the block size was already specified
>> some mkfs utilities does not handle multiple of the same parameters and
>> the mkfs utility fails making it re-try with only provided options
>> (ignoring what user specified), which is wrong.
>
> I disagree strongly with this justification. The test is perfectly
> fine: it is allowed to do whatever it wants with mkfs and mount
> options.
>
> It is up to the implementations of the specific FSTYP mkfs
> implementation called from _scratch_mkfs to handle
> conflicting/unsupported options sanely, not the test....
>
>> In this case it's also a problem for btrfs file system which does not
>> support block size < page size.
>
> i.e. _scratch_mkfs_btrfs needs to either filter that out or
> _fail/_not_run the test if it can't....

For this specific test, having _scratch_mkfs_btrfs filtering it would
still make the test fail on btrfs, as it can pass an offset and length
that aren't multiples of the page size to fcollapse (which makes
xfs_io print an error message to stderr, -EINVAL).

Having it fail/_not_run, wouldn't allow to test for a block size of
4kb, which is the only that works for btrfs on systems with page size
of 4Kb.

How could we make it run on btrfs for the supported case?
I'm interested in being able to run this on btrfs, it's a good tester
for collapse range.

Thanks

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Filipe David Manana,

"Reasonable men adapt themselves to the world.
 Unreasonable men adapt the world to themselves.
 That's why all progress depends on unreasonable men."
