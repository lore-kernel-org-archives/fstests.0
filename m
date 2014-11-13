Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:42677 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbaKMEd6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 23:33:58 -0500
Received: by mail-qc0-f181.google.com with SMTP id w7so10335304qcr.26
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2014 20:33:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141113042231.GD28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
 <20141113032626.GA28565@dastard> <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
 <20141113042231.GD28565@dastard>
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2014 22:33:37 -0600
Message-ID: <CAH2r5mu47ev3=+z7D9tC-jwBpmys=uYe_eooiCa3CtXBNzMXXg@mail.gmail.com>
Subject: Re: xfstest status on current kernels
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 10:22 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Nov 12, 2014 at 09:38:45PM -0600, Steve French wrote:
>> On Wed, Nov 12, 2014 at 9:26 PM, Dave Chinner <david@fromorbit.com> wrote:
>> > On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:
>>
>> >> I want to make sure that I don't accidentally ignore a test (e.g. test
>> >> generic/003 doesn't run with a message " [not run] relatime not
>> >> supported by the current kernel" and want to make sure I am not
>> >> missing something).
>> I have been going through these one at a time as I have time (to
>> see if they are workable on cifs/smb3 etc) - but it can get
>> tricky (e.g. in this case relatime may be default behavior for fs so
>> lack of a mount option with this exact name may be unnecessarily
>> disabling this one on some fs)
>
> I don't think that's the case. Any kernel that supports relatime
> supports the relatime mount option. It doesn't matter if the
> filesystem defaults to it or not, MS_RELATIME is a valid mount
> flag on all supported kernels.

relatime is rejected by the kernel cifs.ko driver (I will need to fix
that) but should be ignored.  Looking at the xfstest logs looks like
noatime is going to have the same problem as well.
I will fix these in the cifs mount parsing.

>
> We require the supported OS for the test to be defined in every
> test. it's pretty easy to check:
>
> $ grep _supported_os tests/generic/010
> _supported_os IRIX Linux
> $
>
> Try to run a test that isn't supported on Linux and you get:
>
> xfs/095  [not run] not suitable for this OS: Linux

If that is the only case where it is Linux specific
that will make it easier to distinguish these from the cases
like test 3 where it is mount parsing related (despite
the message).


-- 
Thanks,

Steve
