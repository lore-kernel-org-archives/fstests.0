Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:6746 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933028AbaIOWSl (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Sep 2014 18:18:41 -0400
Date: Tue, 16 Sep 2014 08:18:38 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: SCSI test target for emulating broken/bad disk
Message-ID: <20140915221838.GI4322@dastard>
References: <CAN05THQcTBMdY4hMXuK-XGRAWAi843S3VmiwppvQ8tTa9ch64Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN05THQcTBMdY4hMXuK-XGRAWAi843S3VmiwppvQ8tTa9ch64Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: ronnie sahlberg <ronniesahlberg@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 15, 2014 at 02:27:55PM -0700, ronnie sahlberg wrote:
> List, All,
> 
> I have been working on creating a "bad disk" for use with testing.
> One aim is for having an easy way to create a SCSI disk that fails in
> certain controllable ways
> to make sure that filesystem code or applications that talk directly
> to a SCSI disk handle
> error conditions and specific sense codes correctly.

Filesystems don't talk directly to the SCSI layer. SCSI is hidden
from filesystems by several layers of abstraction....

> To do things like :
> * flag certain regions of blocks to always fail with certain sense codes
> * cause i/o to certain regions cause the whole device to "hang" for some time
> * torture : "fail 10% of any READs with a certain error".
> * transient errors: make the next #n i/o to a range fail with a sense
> code, then self-heal the device and further i/o complete without
> error.

We're already using dm-flakey for tests that require block devices
that fail specific types of IO or corrupt data. The functionality is
limited at the moment, but it's easy to extend to new types of
failures.

> 
> 
> A very first prototype can be seen at :
> 
> https://github.com/rsahlberg/flaky-stgt
> 
> Please see the README.
> 
> This will probably eventually be merged back into the upstream tgt project.
> 
> Is this something you guys would find useful? If so I am more than
> happy to work with
> you to add what features you need or want.

I can see how flaky scsi behaviour would be useful for testing the
SCSI stack error behaviour, but due to the layers of abstraction it
is not necessarily the best way to do IO error injection/simulation
for generic filesystem testing.

Using DM means we don't have to care what type of block device
people are using - if it can have dm layered on top it can be used
for testing filesystem behaviour on flakey devices regardless of the
underlying storage technologies in use. This is especially important
given that a lot of developers now do their testing inside VMs on
virtio block devices, not SCSI devices.

Hence if your aim is just to improving filesystem error
handling then I'd suggest that adding more features to dm-flakey
and writing xfstests to exercise filesystems one those flakey
devices. If your aim is to provide SCSI layer IO error injection,
then I'm not sure how much use it is going to be to us. I'm sure
if it's useful then someone will come up with some tests ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
