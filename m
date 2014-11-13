Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:5470 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832AbaKMD1P (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 12 Nov 2014 22:27:15 -0500
Date: Thu, 13 Nov 2014 14:26:26 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstest status on current kernels
Message-ID: <20141113032626.GA28565@dastard>
References: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu40qp-m7qZTnbsCKORPn_YYdWGZti32WYPFAJMUs1fhw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 12, 2014 at 05:31:20PM -0600, Steve French wrote:
> Is there a list somewhere of the full set of xfstests that are
> expected to run (and presumably pass) on current Linux kernels for the
> local file systems (ext4, btrfs and/or xfs)?

No.

You should expect all supported tests in the auto group to run for a
given filesystem. i.e. "./check -g auto" should run all the tests a
given filesytem supports, there should be very few failures, and the
only tests that _notrun are tests that aren't supported by either
you kernel or filesystem config.

> I want to make sure that I don't accidentally ignore a test (e.g. test
> generic/003 doesn't run with a message " [not run] relatime not
> supported by the current kernel" and want to make sure I am not
> missing something).

You need to such things yourself and determine if the test should
have run for your given test configuration.

e.g. on XFS you'll get stuff like this if you run with CRCs enabled:

xfs/287 0s ... [not run] 16 bit project IDs not supported on /dev/vdb

because such filesystem only support 32 bit project IDs on disk.

Or if you are missing stuff in your kernel config:

xfs/279  [not run] scsi_debug module not found

Or you aren't running with special subsystems enabled:

xfs/300 1s ... [not run] SELinux not enabled

Or your hardware is lacking in functionality:

generic/260      [not run] FITRIM not supported on /dev/vdb

or test tools weren't built due to missing libraries:

generic/010      [not run] dbtest was not built for this platform

or the filesystem doesn't support the functionality being tested:

generic/024 1s ... [not run] fs doesn't support RENAME_NOREPLACE

All of these things are issues local to the setup being tested, and
so there really isn't a canonical list of what should or shouldn't
run...

> Obviously cifs/smb3 and nfs are not going to run all the tests that
> ext4, btrfs and xfs do but it is easy to leave a test out for the
> wrong reasons (build dependency etc.) so want to know the list that
> should run on a local Linux fs.

Tests should notrun if tests tools were not built due to missing
build dependencies.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
