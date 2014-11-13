Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:41037 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbaKMDjG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 22:39:06 -0500
Received: by mail-qc0-f177.google.com with SMTP id l6so10316266qcy.8
        for <fstests@vger.kernel.org>; Wed, 12 Nov 2014 19:39:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141113032626.GA28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
 <20141113032626.GA28565@dastard>
From: Steve French <smfrench@gmail.com>
Date: Wed, 12 Nov 2014 21:38:45 -0600
Message-ID: <CAH2r5mtdRt+ZX72s-0NO=uxmhMaiFENC1uRUFSPveKZm3S8X=Q@mail.gmail.com>
Subject: Re: xfstest status on current kernels
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 9:26 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:

>> I want to make sure that I don't accidentally ignore a test (e.g. test
>> generic/003 doesn't run with a message " [not run] relatime not
>> supported by the current kernel" and want to make sure I am not
>> missing something).
>
> You need to such things yourself and determine if the test should
> have run for your given test configuration.

I have been going through these one at a time as I have time (to
see if they are workable on cifs/smb3 etc) - but it can get
tricky (e.g. in this case relatime may be default behavior for fs so
lack of a mount option with this exact name may be unnecessarily
disabling this one on some fs)

> or test tools weren't built due to missing libraries:
>
> generic/010      [not run] dbtest was not built for this platform

This is a good example, and one run that I had run into a month or
two ago (at first I had assumed at first
that it was not runnable on Linux, and then eventually
figured out the build dependencies for it to work on Ubuntu and Fedora)
Not always clear to me which of these tests are never going to work on Linux.


-- 
Thanks,

Steve
