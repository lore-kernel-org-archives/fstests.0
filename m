Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788B43159
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909892; cv=none; b=OOnCXDjaOQ2JjPMyG2dx8TedwF77Uw1UsqMXX45JP27e0TPauyW2MMHCGuJ6x+H7Kksp1ZEs3URjPdAe7PxkJHw0/+8ee2AKCn34ZLbZC+IUZyRa8lVbXVn7AFDm0eajBMyTa7brQ3/B1U36ta9WnVeJlayIA95m4Q+sCkiGBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909892; c=relaxed/simple;
	bh=JYfr8hvw2247ZAEKYiu94IuzMfbVgKEUw2nztG6r+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRXd0bWh7RG52u2FKRB7+LLhZnJL44Md5bb09eLJJA6GBLhtzL4I7Cq9j1zPgLKeeP0s05LvZxekvcOh93EGP5Vh6vWHpsrC8ViP40/VvRvBmEeo7j/fhKTk+U4G7Ow0FOx+KO2JHhpR88bt5XfnTduCNRPkxuOQprwLzIaoE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55Q3pPL3025996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 23:51:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 35E712E00D5; Wed, 25 Jun 2025 23:51:25 -0400 (EDT)
Date: Wed, 25 Jun 2025 23:51:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250626035125.GA198321@mit.edu>
References: <20250625212022.35111-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625212022.35111-1-leah.rumancik@gmail.com>

On Wed, Jun 25, 2025 at 02:20:22PM -0700, Leah Rumancik wrote:
> There is a descrepancy between the fsck flags for ext4 during
> filesystem repair and filesystem checking which causes occasional test
> failures. In particular, _check_generic_filesystems uses -f for force
> checking, but _repair_scratch_fs does not. In some tests, such as
> generic/441, we sometimes exit fsck repair early with the filesystem
> being deemed "clean" but then _check_generic_filesystems finds issues
> during the forced full check. Bringing these flags in sync fixes the
> flakes.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Looks good to me, although I might suggest ammending or just dropping
the comment:

>  	# Let's hope fsck -y suffices...

... since obviously, for ext[234] it wasn't sufficient.   :-)

    	  	     	 	     	    - Ted
