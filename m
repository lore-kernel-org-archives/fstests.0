Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:58182 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaKMFKF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 13 Nov 2014 00:10:05 -0500
Received: by mail-qc0-f181.google.com with SMTP id w7so10339350qcr.40
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2014 21:10:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141113044405.GF28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
 <20141113032626.GA28565@dastard> <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
 <20141113042231.GD28565@dastard> <CAH2r5mu47ev3=+z7D9tC-jwBpmys=uYe_eooiCa3CtXBNzMXXg@mail.gmail.com>
 <20141113044405.GF28565@dastard>
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2014 23:09:44 -0600
Message-ID: <CAH2r5mtibBSeNmcbmOsfvaTny7_7AS7Rhh9z8qagGU6T4wjE8w@mail.gmail.com>
Subject: Re: xfstest status on current kernels
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 10:44 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Nov 12, 2014 at 10:33:37PM -0600, Steve French wrote:
>> On Wed, Nov 12, 2014 at 10:22 PM, Dave Chinner <david@fromorbit.com> wrote:
>> > On Wed, Nov 12, 2014 at 09:38:45PM -0600, Steve French wrote:
>> >> On Wed, Nov 12, 2014 at 9:26 PM, Dave Chinner <david@fromorbit.com> wrote:
>> >> > On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:
>> >>
>> >> >> I want to make sure that I don't accidentally ignore a test (e.g. test
>> >> >> generic/003 doesn't run with a message " [not run] relatime not
>> >> >> supported by the current kernel" and want to make sure I am not
>> >> >> missing something).
>> >> I have been going through these one at a time as I have time (to
>> >> see if they are workable on cifs/smb3 etc) - but it can get
>> >> tricky (e.g. in this case relatime may be default behavior for fs so
>> >> lack of a mount option with this exact name may be unnecessarily
>> >> disabling this one on some fs)
>> >
>> > I don't think that's the case. Any kernel that supports relatime
>> > supports the relatime mount option. It doesn't matter if the
>> > filesystem defaults to it or not, MS_RELATIME is a valid mount
>> > flag on all supported kernels.
>>
>> relatime is rejected by the kernel cifs.ko driver (I will need to fix
>> that) but should be ignored.
>
> relatime should never get to the kernel as a string fs specific
> string. It's supposed to be parsed by the mount binary and passed
> as the MS_RELATIME flag to the kernel, not as a string.
>
>> Looking at the xfstest logs looks like
>> noatime is going to have the same problem as well.
>> I will fix these in the cifs mount parsing.
>
> Again: MS_NOATIME.
>
> This sounds like a bug in the mount.cifs binary, not the kernel.

Yes - that is actually where I fixed it (mount.cifs.c). It is easier
to catch it there.

I need to look at what test 3 is doing more carefully since it is
also passing nodiratime and strictatime (which will
also cause problems if not parsed properly) but this test is
unlikely to work across the network due to timestamp
caching issues.   Even turning off metadata caching
(actimeo=0 on cifs mount) only gets partway through this
test on a cifs mount.  It will fail at

"access time has changed for dir2 after file creation"

This (generic/test3) will likely be one that we want to continue
to skip on a network fs.

-- 
Thanks,

Steve
