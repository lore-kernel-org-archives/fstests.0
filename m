Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902C3264DE;
	Sun, 17 May 2026 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779010706; cv=none; b=Q29p97yJc9R/TnrLE+MfT8UCb5Dr0Ix0ysLneToy3dkK6QjSHztKgjGdvNYTTfu3C9/geo1nYDXZqCzoJjAMO58qgOV6HALPa329rrq1DvMePh5nmz+X8mRGsbEyiX/U6XUrQubAiPuIO/X0/W28DtBJW2Ln18nYW2Tagzn7L/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779010706; c=relaxed/simple;
	bh=Cgjsxv7JxrS12D4J0jf4AZjqr8yJ7c3RslZlbxDMMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOOHn84W5jS4nXHhCOOyHba8Hib1XJIREzueHbjA8tu17BjSa/HY9/ynS8fRszI/ZNtorZ+OhiRG75iNh9hFsLvS2/Xi0UVnjNYHlnk628t0v5ozGYkxYrVNsnZYFnaTyRn8So7/idIee/TqCaCpmdP9bzCy1Nq1DrmfwFoqS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfIRemE9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfIRemE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C7AC2BCB0;
	Sun, 17 May 2026 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779010706;
	bh=Cgjsxv7JxrS12D4J0jf4AZjqr8yJ7c3RslZlbxDMMO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfIRemE9KHvqudT2DPmooCYbrsxpfFSfc1Lz1umzbX9/1ejHXwhY0dImlQUKOaRnM
	 oPr6dP/oXOPHkw2q0Brwfrj1Pd7I9imU05tzfl1dR5Cdodf041Lg2R0IG72boTLNRP
	 NAPtIDOpo2qcf6RBu67Xezb5C39YHGZjt0uShxPlSdk7Bv7+RsniLxOQjI/sGe+9Wr
	 5EcPx14BQ4gLbJ7pOpbd3MwL2FOsYMrKBsbm1R8iI1R7NmDufdC1vVHZaHjxKnjpy2
	 +A/Wp2G20Pqi0oV7uRVP3cnEgA/8M9Vr4TWHOAfTErZNMAWxIKZ5PbeXGfpk/65N3X
	 YYJl3vpvglKfQ==
Date: Sun, 17 May 2026 17:38:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, Slava.Dubeyko@ibm.com, linux-fsdevel@vger.kernel.org, 
	frank.li@vivo.com
Subject: Re: [PATCH] xfstests: disable generic/003 for HFS file system
Message-ID: <agmF-PIo1yRu9KHK@zlang-mailbox>
Mail-Followup-To: Viacheslav Dubeyko <slava@dubeyko.com>, zlang@redhat.com, 
	fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de, Slava.Dubeyko@ibm.com, 
	linux-fsdevel@vger.kernel.org, frank.li@vivo.com
References: <20260514200004.354432-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514200004.354432-2-slava@dubeyko.com>

On Thu, May 14, 2026 at 01:00:05PM -0700, Viacheslav Dubeyko wrote:
> HFS hasn't any field in on-disk layout that can keep
> the file/folder access times (atime):
> 
> /* The catalog record for a file */
> struct hfs_cat_file {
>         s8 type;                        /* The type of entry */
>         u8 reserved;
>         u8 Flags;                       /* Flags such as read-only */
>         s8 Typ;                         /* file version number = 0 */
>         struct hfs_finfo UsrWds;        /* data used by the Finder */
>         __be32 FlNum;                   /* The CNID */
>         __be16 StBlk;                   /* obsolete */
>         __be32 LgLen;                   /* The logical EOF of the data fork*/
>         __be32 PyLen;                   /* The physical EOF of the data fork */
>         __be16 RStBlk;                  /* obsolete */
>         __be32 RLgLen;                  /* The logical EOF of the rsrc fork */
>         __be32 RPyLen;                  /* The physical EOF of the rsrc fork */
>         __be32 CrDat;                   /* The creation date */
>         __be32 MdDat;                   /* The modified date */
>         __be32 BkDat;                   /* The last backup date */
>         struct hfs_fxinfo FndrInfo;     /* more data for the Finder */
>         __be16 ClpSize;                 /* number of bytes to allocate
>                                            when extending files */
>         hfs_extent_rec ExtRec;          /* first extent record
>                                            for the data fork */
>         hfs_extent_rec RExtRec;         /* first extent record
>                                            for the resource fork */
>         u32 Resrv;                      /* reserved by Apple */
> } __packed;
> 
> This patch disable the generic/003 test-case for
> HFS file system.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> cc: fstests@vger.kernel.org
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5fe44e21..b897ef0b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4559,6 +4559,9 @@ _require_atime()
>  	ceph|ceph-fuse)
>  		_notrun "atime not maintained by $FSTYP"
>  		;;
> +	hfs)
> +		_notrun "atime not maintained by $FSTYP"

Good to me, thanks! But how about grouping "hfs" together with "ceph|ceph-fuse",
since you want them to share the same _notrun output message. I can help to
change that when I merge it if you agree. Or you can send v2 with my:

Reviewed-by: Zorro Lang <zlang@kernel.org>

Currently we have two kinds of *output* in _require_atime:

        nfs|afs|cifs|virtiofs)
                _notrun "atime related mount options have no effect on $FSTYP"
                ;;
        ceph|ceph-fuse)
                _notrun "atime not maintained by $FSTYP"
                ;;

But the boundary between them seems a bit fuzzy. If the struct supports
atime-related fields, but the mount options don't work or are highly
discouraged, it should fall into the first category (like NFS and CIFS).
If the struct itself doesn't have atime, it should be the second category
(like Ceph and HFS).

But looking at it this way, AFS's struct afs_file_status doesn't seem to
have anything related to atime either. Haha, it's getting a bit messy here.

Thanks,
Zorro

> +		;;
>  	esac
>  
>  }
> -- 
> 2.43.0
> 
> 
