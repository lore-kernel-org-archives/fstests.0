Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfEPRSP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 May 2019 13:18:15 -0400
MIME-Version: 1.0
References: <20190515150221.16647-1-fdmanana@kernel.org> <20190516092848.GA6975@mit.edu>
 <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com> <20190516165921.GA4023@mit.edu>
In-Reply-To: <20190516165921.GA4023@mit.edu>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 May 2019 18:18:02 +0100
Message-ID: <CAL3q7H6gvdhSweJH1W7dbvOtwu8RmzbMRMb9MsSv0D8g+Cm40g@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 16, 2019 at 5:59 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 16, 2019 at 10:54:57AM +0100, Filipe Manana wrote:
> >
> > Haven't tried ext4 with 1 process only (instead of 4), but I can try
> > to see if it happens without concurrency as well.
>
> How many CPU's and how much memory were you using?  And I assume this
> was using KVM/QEMU?  How was it configured?

Yep, kvm and qemu (3.0.0). The qemu config:

https://pastebin.com/KNigeXXq

TEST_DEV is the drive with ID "drive1" and SCRATCH_DEV is the drive
with ID "drive2".

The host has:

Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
64Gb of ram
crappy seagate hdd:

Device Model:     ST3000DM008-2DM166
Serial Number:    Z5053T2R
LU WWN Device Id: 5 000c50 0a46f7ecb
Firmware Version: CC26
User Capacity:    3,000,592,982,016 bytes [3,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ACS-3 T13/2161-D revision 3b
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)

It hosts 3 qemu instances, all with the same configuration.

I left the test running earlier today for about 1 hour on ext4 with
only 1 fsstress process. Didn't manage to reproduce.
With 4 or more processes, those journal checksum failures happen sporadically.
I can leave it running with 1 process during this evening and see what
we get here, if it happens with 1 process, it should be trivial to
reproduce anywhere.

>
> Thanks,
>
>                                         - Ted
