Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929027F18B;
	Sun, 21 Jun 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057393; cv=none; b=SBmk3NyVdQz1GSiD6p1Ftc0QjdCzKK+Iw4JDZoDuV0VeL7tcDl8wp+j168lf+x47wlCOHaRwsbLYbIMRSQvPYeObMzBaorrSQuXCrFXE3NUsTVKzHKTA1K9WynomP2GW6ugE8t/DsenPT/Z5wgBYJREwPfUtO9zPpxO5NQmx5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057393; c=relaxed/simple;
	bh=2RBglxdyeDhl1xH+kLN/AlmaGlMh64L1wjldXFsdx1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPbNq3LleiC4WB5BRrHvmZFcv4Zib9LAdZq3kpCorg7hRwn/ZFJU1NRqs5WsQzanxalHDlqjgImKTlFzJGid86Ud5AQkTmHmwWaPF2o7NliFNuLw0gEj6SwoDS538c97xhU5gBF9qmURDm++fq+YVw7BQH23N00+PEKjz3m31Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okGct+pN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okGct+pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89231F000E9;
	Sun, 21 Jun 2026 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057390;
	bh=RTZTAwQLyygIOE3RvuFHtfjxbf9xe54p22A5gPa68lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okGct+pNy6NRNH2NpFCIjXh2k5SUxu0ak8mcBH9gqNSwVvM4oDQ9GfcMExAiyNn8I
	 BtSnlTpvcoEV3m4OiIvzz7oFg28eJZ0qKn+JVWe5BcCmK6QkAFhhDRzO2Xt1ZNZjDA
	 HI5ltfBvrWrQghUM7Zq5/F4bLvaSEbtD1Kgc4GlQ8TYvnAE5YUs/ZWsPdOxMFY9w5D
	 Rk3yQ0MipA+QcAr7ZF+LqXrAvR11tFLOqD6hgAJU67p2yBJ+3h01V5L6HJyqk3PgPN
	 LEqcpUAeWzXzfoSiBx7AdcgejY21m1OBb7pzNy79870A0ivaanRNrsWlYeZ3bmUXqo
	 A8Mgi6MCZgTgQ==
Date: Sun, 21 Jun 2026 23:56:25 +0800
From: Zorro Lang <zlang@kernel.org>
To: German Maglione <gmaglione@redhat.com>
Cc: fstests@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] vfstest: move sys_umount2() to cleanup path in
 tcore_acls()
Message-ID: <ajgJYwuiwxnqcJIE@zlang-mailbox>
Mail-Followup-To: German Maglione <gmaglione@redhat.com>, 
	fstests@vger.kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
 <20260618-xfstests-tcore-acls-fixes-v1-1-45a1aec1d99d@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-1-45a1aec1d99d@redhat.com>

On Thu, Jun 18, 2026 at 12:11:53PM +0200, German Maglione wrote:
> sys_umount2() in tcore_acls() only runs on the success path. If setfacl
> fails (e.g. no ACL support), the mount on DIR2 is left behind and
> test_cleanup() can't remove T_DIR1. This causes every subsequent test
> to fail with EEXIST on mkdirat(T_DIR1).
> 
> Move sys_umount2() into the out: block so it always runs.
> 
> Signed-off-by: German Maglione <gmaglione@redhat.com>
> ---

Makes sense to me, thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  src/vfs/idmapped-mounts.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index ed9992f975c14b57c5d6d1634ca011b015b78bcb..d0630f5931ade713a99f5dec1cbe24bdaa75d35d 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -240,12 +240,11 @@ int tcore_acls(const struct vfstest_info *info)
>  		goto out;
>  	}
>  
> -	snprintf(t_buf, sizeof(t_buf), "%s/" T_DIR1 "/" DIR2, info->t_mountpoint);
> -	sys_umount2(t_buf, MNT_DETACH);
> -
>  	fret = 0;
>  	log_debug("Ran test");
>  out:
> +	snprintf(t_buf, sizeof(t_buf), "%s/" T_DIR1 "/" DIR2, info->t_mountpoint);
> +	sys_umount2(t_buf, MNT_DETACH);
>  	safe_close(attr.userns_fd);
>  	safe_close(dir1_fd);
>  	safe_close(open_tree_fd);
> 
> -- 
> 2.49.0
> 
