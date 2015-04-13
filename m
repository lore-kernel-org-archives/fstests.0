Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41558 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbbDMLwf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 13 Apr 2015 07:52:35 -0400
Date: Mon, 13 Apr 2015 19:52:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC PATCH] fstests: _require_metadata_journaling in
 _require_dm_flakey
Message-ID: <20150413115232.GU16808@dhcp-13-216.nay.redhat.com>
References: <1428063285-31140-1-git-send-email-eguan@redhat.com>
 <55229C4B.1090208@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55229C4B.1090208@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 06, 2015 at 09:46:35AM -0500, Eric Sandeen wrote:
> On 4/3/15 7:14 AM, Eryu Guan wrote:
> > Tests take use of dm-flakey target should require metadata journaling,
> > so move _require_metadata_journaling call from each test to
> > _require_dm_flakey to ease the process, though it seems unnecessary to
> > btrfs or xfs specific tests.
> > 
> > This change also makes generic/039 generic/059 generic/325 require
> > metadata journaling automatically, and any new test that calls
> > _require_dm_flakey.
> 
> I'm not sure this is a great idea... I think _require_metadata_journaling
> should only be used when we expect filesystem consistency after a
> (flakey) shutdown.  We can use dm_flakey to test fsync persistence
> on vfat, for example, right?  But with this change such a test won't
> run on vfat or many other filesystems even though the test for persistent
> data would be perfectly valid.
> 
> -Eric

Yes, you're right. Thanks for pointing this out!

Then I think generic/039 generic/059 and generic/325 still need
_require_metadata_journaling, I've seen generic/059 fail on ext2(using
ext4 driver). I'll send another patch to fix these issues.

Thanks,
Eryu
