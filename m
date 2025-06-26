Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C42F1FCE
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944787; cv=none; b=W9ELM1kOWWvaJceCzf9HpNaqiw4Ajo7XzYndnMVWL9C00DOJrlnQwVuYAQ/3H/U2LHNpHDI0WdOavhPkl1+c1ngB0/rk/Qti132u5cgALUj39wnk0OXoqAKHVYDlq+waIu+5ZKqDHdLCY4PpNvOo805mYSL7hu2fZQNdJrKlZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944787; c=relaxed/simple;
	bh=yjTEaEbVTMKsxlaZ6UQlSH/zDyBXkqaBSocyWQ0Hn1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hahzC4omwTRgTY+mTFOhpPitrlktINoom0WkAmO/t3zQ6ZMo0BYyHI9SBFoYx2yIs8xYhy/t99EOJIsO2hhsa8HMb4ZFBY7lDgEd/HLkmQggBR9kXJVtBeEA/oAY0o5N1xL5WS7BmTs2kdMYm33LWGBhID65pHw5cZ6qGEAepiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55QDWds9012422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 09:32:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 719542E00D5; Thu, 26 Jun 2025 09:32:39 -0400 (EDT)
Date: Thu, 26 Jun 2025 09:32:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com
Subject: Re: [PATCH v2 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <20250626133239.GA7524@mit.edu>
References: <cover.1750924903.git.ojaswin@linux.ibm.com>
 <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f09b788f506223c9631479d0318be1e1ba5883c.1750924903.git.ojaswin@linux.ibm.com>

On Thu, Jun 26, 2025 at 05:28:53PM +0530, Ojaswin Mujoo wrote:
> This is achieved by defining a new function _set_default_fsx_avoid
> called via run_fsx helper. This can be used to selectively disable
> fsx options based on the configuration.

> +_set_default_fsx_avoid() {
> +       case "$FSTYP" in
> +       "ext4")
> +               if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> +                       export FSX_AVOID+=" -I -C"
> +               fi
> +               ;;

This assumes that MKFS_OPTIONS reflects the file system features
enabled on the file system.  That's true by definition for the scratch
fs, but it's not necessarily true for the test fs.  At least in
theory, someone could run fstests without a scrach device, and then
MKFS_OPTION?S might not be set.

I'm not sure that we care; is this something that we make assumptions
in other tests?

					- Ted
