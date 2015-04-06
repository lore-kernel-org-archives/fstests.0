Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:37158 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbbDFOqh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 6 Apr 2015 10:46:37 -0400
Message-ID: <55229C4B.1090208@sandeen.net>
Date: Mon, 06 Apr 2015 09:46:35 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] fstests: _require_metadata_journaling in _require_dm_flakey
References: <1428063285-31140-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1428063285-31140-1-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 4/3/15 7:14 AM, Eryu Guan wrote:
> Tests take use of dm-flakey target should require metadata journaling,
> so move _require_metadata_journaling call from each test to
> _require_dm_flakey to ease the process, though it seems unnecessary to
> btrfs or xfs specific tests.
> 
> This change also makes generic/039 generic/059 generic/325 require
> metadata journaling automatically, and any new test that calls
> _require_dm_flakey.

I'm not sure this is a great idea... I think _require_metadata_journaling
should only be used when we expect filesystem consistency after a
(flakey) shutdown.  We can use dm_flakey to test fsync persistence
on vfat, for example, right?  But with this change such a test won't
run on vfat or many other filesystems even though the test for persistent
data would be perfectly valid.

-Eric
