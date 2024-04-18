Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98215AAD9
	for <fstests@vger.kernel.org>; Thu, 18 Apr 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432443; cv=none; b=q+ZvwSVL9jVwhrdQn+5maLTtPUzzPKeOeetXU6+ZsPwxvfA+1gAf1b12lhHPSjRdn/yp/4beHttJUTtgV/hHt9QezKEuijKTFCMdGmSvuU9/ql/lhbnaBGUuOEfbP4SGVPbSEgSNp0Y3ks9DPWQ5FrnCgs03U9uWlRy7wt0yVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432443; c=relaxed/simple;
	bh=oJy9uYVovZn1tsiNop2dWNoof78hvd/JaQD5NXStioM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Exn0PGfpoKEyK/JmpZ0p6wgZ8AMfGUVoHIE3SO10u2AOkCZo4PtHlHHl3VwXJH1BoU/+9EFtbVLtogFqcI9/Jwi/zJtQlLwTpWHP+VqCeL/UcLzVlZsO2L6Zi5l2rxQv4/BULkN8H30M15lR2ec0BukdTzMFUYzTGomqbTdUWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH7VGLid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH7VGLid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2F0C2BD11;
	Thu, 18 Apr 2024 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713432443;
	bh=oJy9uYVovZn1tsiNop2dWNoof78hvd/JaQD5NXStioM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PH7VGLid9Ap4aBqDBh4aMQwASeug2E8td2OjnT7WULnoJkV3ROtX0FvwjDLP6nzBg
	 miEdVXYDzr7ts2i3WbL8CW3YoHJr+In0XfzLZW27LTXgsSZaTwCOmrNeUgpwBFGaKC
	 6j4oB9sFDBMk+U2vbUzN6+R7UUR3JcfQaJ+UoKkWGrwbZU/C/SY0fdFfj8+VRiE87L
	 z/SVEE5a7v+OKLAKXq5nbDVCdtfKQWpnUCfILu3zhOQsmlCnRzh/qvLPfXMML22Yv5
	 oD28QYi6V4Tqqa3/1zQLA2gdFOuC3W3xEJxd6GnLyPVD+6hw0lyQiaMFs2Xl5Djxma
	 Hv2STk30TeADA==
Date: Thu, 18 Apr 2024 17:27:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: tjackson9431@gmail.com
Cc: fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/645: Add hint for expected failure with old
 kernel
Message-ID: <20240418092718.rprypnitzsr43k2k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
>  tests/generic/645 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/645 b/tests/generic/645
> index 556d2450..bcc3e3b5 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -17,6 +17,8 @@ _begin_fstest auto quick idmapped mount
>  _supported_fs generic
>  _require_idmapped_mounts
>  _require_test
> +_fixed_by_kernel_commit dacfd001eaf2 \
> +	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"

Thanks for helping to confirm that. Just, if it's not a regression bug
fix, maybe better to replace the "_fixed_by_kernel_commit" with the
"_wants_kernel_commit". If no objection, I can change that when I
merge this patch :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  
>  echo "Silence is golden"
>  
> 
> ---
> base-commit: e72e052d56c3f05e533f4b67056f86931f688368
> change-id: 20240417-generic-test-645-18750d02523e
> 
> Best regards,
> -- 
> Taylor Jackson <tjackson9431@gmail.com>
> 
> 
> 
