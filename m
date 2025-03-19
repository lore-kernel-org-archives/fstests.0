Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063921324D
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356708; cv=none; b=GJlF8RQxx9oqAkDZjh+C7dD0XKnvzbcZIR9F+EtQg+0FAwHSCt3+iC60FSdf4MybV7YxEk4fLkf5JrDNQGIAWeRko1IdXT4a/gIpg+U3nM9Tpvji15c7zvGtxPax4g0RyTaJpR+6f47cW/I2vB/gJztgnT0QTUPEYw4NhDF5BB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356708; c=relaxed/simple;
	bh=tZgAcG1Bbj/mNoICVzBW6YeUa85pkzN/yarlqwpealQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqc/zjpcsTZluvfj7MK11UR26HEhMK7GGsSJmoFbkBcIgX8U24s/RJW+3jlARy35aoZu8HSsVheryVoAOFYe9g4SE5kNiyHS/mkchJ23TQ0RV5kKNmZVOd/MOjPTfpZuRE7fwDdTUKN32zOf9Rj7qig4qoBPFg8oe5OkOehybbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52J3wF55020900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 23:58:16 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D26D32E010B; Tue, 18 Mar 2025 23:58:15 -0400 (EDT)
Date: Tue, 18 Mar 2025 23:58:15 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319035815.GG787758@mit.edu>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>

On Tue, Mar 18, 2025 at 07:58:05PM -0500, Eric Sandeen wrote:
> 
> I shouldn't have said "failed" - you're seeing what I'm seeing, it's 
> skipped (not failed) because it tries to test overlayfs idmapped layers
> using the ext4 default options, and acl mounts fail, skipping the test.

Ah, OK.

Hmm... I think the fundamental problem is that _overlay_mount_dirs()
shouldn't be using _common_dev_mount_options().  Depending on the file
system configuration that we might be testing, MOUNT_OPTIONS might
include any number of things which overlayfs might not understand,
including things like: "nfsvers=4", "data=journal", "dax",
"test_dummy_encryption", "trans=virtio" ,"version=9p2000.L"
,"posixacl", "prjquota", and probably quite a few others.

After all, we'd want to test overlayfs on top of (for exaple) 9pfs
with generic/699, and in that case, MOUNT_OPTIONS will be set from
PLAN9_MOUNT_OPTIONS, and will contain options like "version=9p2000.L"
that overalyfs has no hope of handling.

What I'm wondering is what mount options _overlay_mount_dirs() needs
from _common_dev_mount_options()?  Why is it there in the first place?
If there are some specific mount options that we need to pass on to
overlatyfs, maybe _overlay_mount_dirs() should be grepping out
whatever mount options. it needs, instead of just blindly pulling all
of the mount options?  Or, maybe _overlay_mount_dirs() sould avoid
calling _common_dev_mount_options if FSTYP != overlay?

				     	      - Ted

