Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:11856 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbcCCVCN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2016 16:02:13 -0500
Date: Fri, 4 Mar 2016 08:01:31 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstest groups for network file systems
Message-ID: <20160303210131.GS29057@dastard>
References: <CAH2r5mtMDzqQZ0fyyHSxmyEcwWF+doXO+fPRtAwCgfPf=2ppMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtMDzqQZ0fyyHSxmyEcwWF+doXO+fPRtAwCgfPf=2ppMg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 03, 2016 at 10:53:41AM -0600, Steve French wrote:
> In experimenting with automating tests better for network file systems
> (NFS and CIFS/SMB3), I noticed that xfstest doesn't have test groups
> that help distinguish a good subset of tests to run over them.  My
> goal was to have an easy way to run:
> 
> - a quick (under 15 minute) build verification test of SMB3 (and also
> similarly for NFSv4.2)
> - a full regression test of SMB3 (and also NFSv4.2) that runs all valid tests
> 
> The existing test group "quick" has some tests that are quick only for
> a local filesystem and can be quite slow when run over a network.
> And there are few file system specific test groups (there is one for
> udf).
> 
> I have a patch that adds a "cifs-quick" test group (can be changed to
> "smb3-quick" if anyone prefers that name since our goal is to test the
> more important, newer dialects) and a "cifs" (or "cifs-slow" or
> "cifs-full").  Similarly I have one for "nfs-quick"
> 
> But before I submit there are two obvious questions:
> 1) Should these test groups (in particular "cifs-quick" and
> "nfs-quick") include any tests that we know will fail today? (e.g.

Don't care.

> 2) Should we create additional test groups by dialect or target server
> (e.g. smb3-quick vs. cifs-quick vs. cifs-samba-quick vs. nfsv3-quick
> vs. nfsv4.2-quick)? 

Again, don't care.

Test groups are simply arbitrary collections of existing tests. If
you want to maintain a set of tests for this purpose, then simply
send patches to annotate all the existing group files.

However, it will be up to you in future to add relevant new tests to
those groups, as you cannot expect other developers to know what is
a fast/slow test for nfs/cifs when they add new tests.

> and there
> are tests which require fallocate so will fail to servers or server fs
> that don't implement punch hole, zero range etc.

They should fail the _require* rules for the given feature and so
tests that use those features should not run on filesystem/server
combinations that don't support those features.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
