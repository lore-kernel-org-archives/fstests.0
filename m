Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC55024E
	for <fstests@vger.kernel.org>; Wed, 27 Mar 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535501; cv=none; b=dp5WGFHmr1RsJf87gnVk4fQ+yVSX8XKWIJa9QbGCFAiRkdaqqufp1PLXxBHBuPvYS/WQTv5DdUc9QNTTfzNaeQ2XTttmoO7hdXCfO1AFvV3CYu/89hipIOoIaGnLSnpoI6YurdNVL+89YYCONp/Td8PeXmMrm8owwr80jHXkQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535501; c=relaxed/simple;
	bh=8nsIBdtQPUHnrKngo2Llur3/q3uCGo541pWvjvUNM9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axkxx1xHRjSFlMveiox/oi85fb7l0/i2DRQh+I0IWx8Lsxvi7b87tsbKBjaq95CRvfk76XDMh0v0T6nJAD2uT4lVp5R2NAltb/lmjv6g0nddOLuhXk+PWUbj/mbPbgAdMPcfuDe5aZnfIIxGSebPA2e7DcusreLsoBKr0b5dVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id6DRlrN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id6DRlrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B11BC43330;
	Wed, 27 Mar 2024 10:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711535501;
	bh=8nsIBdtQPUHnrKngo2Llur3/q3uCGo541pWvjvUNM9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Id6DRlrNdqv0hViZfp7Z8xbKX6rE4FI166ooQgJUJ4dsXcJFDB7pe3Q6A6Uol4Xun
	 2JI+SoVELux7w+Pc0poRGnzO01rcq129OMeytCJvE5jRroUQCrj8umECJqmnXHs9ed
	 +coi9+MG9MVj4quNrxzuilf1O1v6W9n5eBe/uDN0/ljnDQY3LazfbPZuomkgU839CS
	 GLTGCrqQeSv1GkH2uSMX6faHwFgeXAR/k3v8bEoTXwE13pu6W6wwte6iQaVLlIMHCJ
	 h4YrF04m39xRzzlR4EH0KfpoA2eI6ZsB8sa5P6yXVUYsRnJ07OlDaxbyf1531aTnp9
	 doO2kdIgYxrsw==
Date: Wed, 27 Mar 2024 11:31:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: tjackson9431@gmail.com
Cc: fstests@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] vfs/idmapped_mounts.c: Incorrect array index for
 nested user ns
Message-ID: <20240327-zerrt-abstammen-6aecd73043ef@brauner>
References: <20240326-mount-setattr-test-v1-0-c061b040d0f7@gmail.com>
 <20240326-mount-setattr-test-v1-1-c061b040d0f7@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326-mount-setattr-test-v1-1-c061b040d0f7@gmail.com>

On Tue, Mar 26, 2024 at 08:33:51PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <tjackson9431@gmail.com>
> 
> Within the vfs test for idmapped mounts, the function nested_userns()
> is using an incorrect array index when attempting to set up the mapping
> for the 4th nested user ns within hierarchy[4]. The correct index that
> belongs to the 4th nested user ns is actually hierarchy[3].
> And hierarchy[4] is reserved for the dummy entry that marks the end
> of the array.
> 
> Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
> ---

Ah, thanks for fixing this!
Reviewed-by: Christian Brauner <brauner@kernel.org>
