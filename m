Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C61DD0D5
	for <fstests@vger.kernel.org>; Tue, 18 Mar 2025 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341890; cv=none; b=TIvXfh74jOwp8PKnzU6EoWa8bIaYS3TVjzqvrwfwoA1uuwaT25q8bmGCYv7S0E5T2n3GFrf0P5+/laeygPT8PKIUr5cnHfKiN45cJMxuFwx3B/TCsNtzgMM5T1xslf74lV2kycfDrYpigmbv8MYEYdofAYRf9ThagvJ31vtVhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341890; c=relaxed/simple;
	bh=GnWfEeOytzd8hqzzLUkr1tpffCvxjE8HPBd0U257+sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3vH9z6qZO/Zxs7LWvDtJuOcIbsFHsfJ5+Xy7KYqPpwNQKjBJT3lh0yPdsd4nkGcNJXT8HxLUkm7PlU/HIA1UFxESCf0+vHQJbojZMSMESgxnI02BVPPiO6keQewtJLNsrOKGLxdasZPpUJKAQ6wLGat0X/xxqJzJksW73Nypx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52INpGOt019353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 19:51:17 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 60B022E010B; Tue, 18 Mar 2025 19:51:16 -0400 (EDT)
Date: Tue, 18 Mar 2025 19:51:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250318235116.GE787758@mit.edu>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>

On Tue, Mar 18, 2025 at 03:39:33PM -0500, Eric Sandeen wrote:
> generic/699 fails because _overlay_mount_dirs() uses _common_dev_mount_options(),
> and when FSTYP is ext4, that yields "-o acl,user_xattr" and acl is not a valid
> option for overlayfs.

Hmm, I hadn't noticed because the test is getting skipped for me:

BEGIN TEST 4k (1 test): Ext4 4k block Tue Mar 18 19:44:51 EDT 2025
DEVICE: /dev/vdb
EXT_MKFS_OPTIONS: -b 4096
EXT_MOUNT_OPTIONS: -o block_validity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.14.0-rc2-xfstests-00063-g6630cf085eb0 #14 SMP PREEMPT_DYNAMIC Mon Mar 17 11:19:56 EDT 2025
MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc

generic/699        [19:44:51][   12.536740] run fstests generic/699 at 2025-03-18 19:44:51
[   12.794084] overlay: Unknown parameter 'acl'
 [19:44:52] [not run]
        generic/699 -- overlayfs doesn't support idmappped layers
Ran: generic/699

I haven't really played with idmapped mount.  Is there some CONFIG
option I need to enable this test to run?

						- Ted

