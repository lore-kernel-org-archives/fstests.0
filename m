Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6D15E20D
	for <fstests@vger.kernel.org>; Thu, 18 Apr 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438867; cv=none; b=b1qbKAahamD5K2EOGBgdkjImrbuexfo/mLHkp9B9ax2sH/VMnD/OgyUe7/5FHCFi2W0V9qsW/11o6fDo29juZNtjzQxRSQPwOE5/JoLIoubnPxog5iJQQS9y+X41eV8Lw0qJHIL/mkcegOcnRhU19VqstGCfTplhyOnV93Dat6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438867; c=relaxed/simple;
	bh=4ZQSCPxNstqawodqiTNiToOhYB+Pq13sQQSfAvLv0k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqdd720DpgmSGM60k4P+Nl5QS6FZFpsXeWoVksxG1l+RIK7+8ey0HmLCVt2QacYVd41migvPKCJ2cA0iULliLDA1Umr5nxHRyeKSUydqhA0AerEkt8kVrkTXzQKRJh2qPC6vY4vN1i7fhfEyUADzWvVru5Pd+myamSgpRtydjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk0b5tmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk0b5tmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7088C113CC;
	Thu, 18 Apr 2024 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713438867;
	bh=4ZQSCPxNstqawodqiTNiToOhYB+Pq13sQQSfAvLv0k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fk0b5tmK8xoACaRbPPPkhSLlehXVKmH+euhGRDQVuGgxHGfNcOceKGiAgBrWbOZp5
	 6FOcbTDA9TCsKkpbtxKRPRtQvhBSY+I2Bwzlpx9LI8okqGV2UFPMwzNwvMMuaE4Fqb
	 f63v19Q+dbshenclyNKG3QS/Z0hPv8B7S9dRUoVHOaM1xvCgBNMDNo1P9D657+0i20
	 8X9Q2eURU/MdadsPlmsJfMOXLDbsdet1dBFkhIB9HbaS/jyFsBQ+TRtyBv1gc6Vg03
	 wwn6nTvmNhdecwz4AU76zTGI22Q/rM5h7l6dGTocRjGAClrjsw1KYrmQs8jfpJHCkY
	 Vkf24UVHVWSNQ==
Date: Thu, 18 Apr 2024 13:14:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: tjackson9431@gmail.com
Cc: fstests@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/645: Add hint for expected failure with old
 kernel
Message-ID: <20240418-getan-deckmantel-30bc56fdafb0@brauner>
References: <20240417-generic-test-645-v1-1-7f6f496af06a@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417-generic-test-645-v1-1-7f6f496af06a@gmail.com>

On Wed, Apr 17, 2024 at 07:34:24PM +0000, Taylor Jackson via B4 Relay wrote:
> From: Taylor Jackson <tjackson9431@gmail.com>
> 
> The following hint is added to reflect that any old kernel
> without kernel commit dacfd001eaf2 (“fs/mnt_idmapping.c: Return
> -EINVAL when no map is written”) is expected to fail this generic
> 645 test since without that commit, mount_setattr won’t return
> EINVAL when attempting to create an idmapped mount using a user
> namespace with no mappings.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Taylor Jackson <tjackson9431@gmail.com>
> ---

Thank you!
Reviewed-by: Christian Brauner <brauner@kernel.org>
