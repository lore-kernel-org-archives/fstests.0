Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C11C2D
	for <fstests@vger.kernel.org>; Wed, 31 Jan 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684785; cv=none; b=byuLKsE4iGtPEjR9T6oP8ZzRorkkxKH4diW8DPOqzZxAf+PbgulFRBWfdIXVKwh6rqUeMDlsYZNWdt3GdzsHp1k7iCDmMFrGmn+HiXVT+thRe0+epi9RHWptfDC/m0GcuQi30d9josmmDJWkXGa9jx4RvmgdHiiI6LKZrq6DJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684785; c=relaxed/simple;
	bh=002xN0PyseooMGoCDj1UADbJKEz11/pjRL4gxIyDK+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndLI7EpbB6IpQJm6vtWV6qmq219bRQL6iTuLf7R+qAd3zk02dH+A3x4RBsgtrOuGwLLU9wfS95JI46ppLIUm7pa3f2ScC8gijkoaElR7pSFLBaYyQTm3q7Z9CfRQhQxOdIRuWlTlKh0cBOVtq4KQZR9f5on+FuLvTBJunGjibvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Sr9JYyt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jh3ae4Aj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Sr9JYyt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jh3ae4Aj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Sr9JYyt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jh3ae4Aj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Sr9JYyt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jh3ae4Aj"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 103E11FB56;
	Wed, 31 Jan 2024 07:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706684781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/dYsoc0kImxSW/RaMH4eAnlmHZ/qwX3hBw6rW6QJDs=;
	b=1Sr9JYytMoBanSwsnPIQNJAthH2FMLp7e8qdI45/HHj0Y6Gp/IhhR3viNO3XW4CpqmEpbQ
	rxVCaoGArbjgdBCUK6QvLKeJB8LAHfp7jm2Japl9toV5VBvhrO6Tzi5klcHTyPYvw2xkW9
	rUXg/x8IzKtZgVluyH/7Rxiinn2NB3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706684781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/dYsoc0kImxSW/RaMH4eAnlmHZ/qwX3hBw6rW6QJDs=;
	b=jh3ae4Aj0SkMCPEJh2pGaEH3CdhCxzrrFeVt17gwSe62tdV/olZlNWlZpSSLly7e1i1T1p
	UXE/kLH7IoGfA3AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706684781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/dYsoc0kImxSW/RaMH4eAnlmHZ/qwX3hBw6rW6QJDs=;
	b=1Sr9JYytMoBanSwsnPIQNJAthH2FMLp7e8qdI45/HHj0Y6Gp/IhhR3viNO3XW4CpqmEpbQ
	rxVCaoGArbjgdBCUK6QvLKeJB8LAHfp7jm2Japl9toV5VBvhrO6Tzi5klcHTyPYvw2xkW9
	rUXg/x8IzKtZgVluyH/7Rxiinn2NB3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706684781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/dYsoc0kImxSW/RaMH4eAnlmHZ/qwX3hBw6rW6QJDs=;
	b=jh3ae4Aj0SkMCPEJh2pGaEH3CdhCxzrrFeVt17gwSe62tdV/olZlNWlZpSSLly7e1i1T1p
	UXE/kLH7IoGfA3AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D605C132FA;
	Wed, 31 Jan 2024 07:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id slwgMmzxuWVoBwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 07:06:20 +0000
Date: Wed, 31 Jan 2024 08:05:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] t_snapshot_deleted_subvolume: change the position of
 macro definition
Message-ID: <20240131070555.GG31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Fri, Jan 26, 2024 at 03:04:23AM -0500, Yang Xu wrote:
> On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
> macros BTRFS_IOC_SNAP_DESTROY_V2, BTRFS_IOC_SNAP_CREATE_V2 and
> BTRFS_IOC_SUBVOL_CREATE_V2 are not defined. This will cause compile
> error. We should always check these macros and manually define them
> if necessary.

The BTRFS_IOC_SNAP_DESTROY_V2 was been added in 5.7 but the other two
have been around since ages. This looks like there are missing
configure-time checks for the macros.

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/t_snapshot_deleted_subvolume.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
> index c3adb1c4..d84ba35a 100644
> --- a/src/t_snapshot_deleted_subvolume.c
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -20,21 +20,6 @@
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #endif
>  
> -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
> -#ifndef BTRFS_IOC_SNAP_CREATE_V2
> -#define BTRFS_IOC_SNAP_CREATE_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
> -#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
> -#define BTRFS_IOC_SUBVOL_CREATE_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
>  #ifndef BTRFS_SUBVOL_NAME_MAX
>  #define BTRFS_SUBVOL_NAME_MAX 4039
>  #endif
> @@ -58,6 +43,21 @@ struct btrfs_ioctl_vol_args_v2 {
>  };
>  #endif
>  
> +#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SNAP_CREATE_V2
> +#define BTRFS_IOC_SNAP_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
> +#define BTRFS_IOC_SUBVOL_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
> +#endif

So you're moving the conditional definitions out of the ifdef that
includes the header where they're supposedly defined, this should be
really done in configure and ifdef only BTRFS_IOC_SNAP_DESTROY_V2 as
it's the newest one.
