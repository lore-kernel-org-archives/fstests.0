Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE4C1CCB4B
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402664; cv=none; b=N/OpxcA7QKdVAUXlFf18UqJonjWqX1Vsk4GUOxXkRkG40WeG7JY9qcfhBHvHdA+XTrzW0c4tKLzi7G5tUujIFHFM6KJFidxLRMr7OyjefSpF2KMAZxD7N+XInSLMxeiZVhbmaciyhL6nz97KdLMh5nJhZQVcD9NhpyBrgdGTUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402664; c=relaxed/simple;
	bh=VPiEXyZSMeiEk9EMXT8AxQ4uvSh8TQ30/3DPowTD0wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNDiL93v4aj+aFjKhypbA0WK+8wynfTco3oPRVY/bp8XbTPW+WkG34c/XNQkfYzmBzgGkTtSsx17Ibk5J0TE1hcRVQOZebXD8h33TdfpSoOs+RjRIyEh5cEme+gEdssr/Nyjz0aTZvVXI7m2vQyOB9vE/i+qRl6+ny3cX6ATjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JGiA6m018241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:44:11 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 786982E010B; Wed, 19 Mar 2025 12:44:10 -0400 (EDT)
Date: Wed, 19 Mar 2025 12:44:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Christian Brauner <brauner@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319164410.GB1061595@mit.edu>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Wed, Mar 19, 2025 at 11:39:02PM +0800, Zorro Lang wrote:
> 
> I've forgotten why I left g/699 to generic, not in overlay. Maybe
> Christian hope to run these two cases together in one FSTYP test
> round (don't need to run overlay test once). I'm good to move this
> case to tests/overlay/, cc Christian to check his review point.

I had assumed it was because we might want to test the combination of
overlayfs with a variety of different underlying file systems?

If we move this to tests/overlay, I'd still be able to do this kind of
testing via:

  {gce,kvm}-xfstests --primary-fstype {ext4,xfs} -c overlay/default -g auto

This allows me to test overlayfs with the underlying upper and lower
directories being either ext4 or xfs.  (I could and should extend this
to support other base file system types, via some minor changes to
test-appliance/files/root/fs/overlay/config, but I had never gotten
around to it.)

How do other people who are testing overlayfs handle this?

						- Ted
							
