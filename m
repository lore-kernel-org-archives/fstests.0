Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9683D6CDE;
	Wed, 20 May 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273376; cv=none; b=DickfvuGo5TY8tMT5du2kbWqgIbyh/vF61aTXVT3lRPMLOCum09IBp1rU3e9GPDk104tg9+QA2Y1GC0F5mEWIQ8IaCzJSwHVWAALxzKR+yn6OiXxAn9cg+v7oZLmBvxVmHghJFvG/1erZr5sCsu07G6aUA8mAd0SMGyXkOIrdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273376; c=relaxed/simple;
	bh=L1Wb3zEfNNkdT7zV2PzG8/2wJqS2ao5C3LY8S+tZhKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ8Rx2Ze91hrEnE8+aOGS34YP05tQUR1lG04SAh6Cdfug533195M1l34lMKXioX/qIq8AXWIzXQB1jqgvSsUOzInR23xQ5fxJYvzdltjwwnsk2103eRJcscC+tKfcsgJ2rnFoyauLUbOoCBW1ko5PL1GQjjlQo9gN6vYwPKZDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjsfbsXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjsfbsXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81CC1F00893;
	Wed, 20 May 2026 10:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779273373;
	bh=cwX7WMzB3XSP5JCBGi4fhXM6QoPkrhKmDcY5/WNc3m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fjsfbsXwGP3a+plBAu7Vs6pRl7q9akjfcia77L9Tggc11hjUGSy/Vtzq6Elhty6OZ
	 TI15+RB0PKAmIZtobwOtZxi0z85nerMFSDUkDnkj4El9aSZpMq9GFbOlxZA/1tuuka
	 bpZtC01gsW52Fd7yX0pKgMeK8FyYZ8sdOJBBZhq+sYQiDbMZoAutMAsI5c0HztIRb+
	 qnpnOmBcbLI/XQzeI7v3196AaO4EHmrobrFkLK5fouzwtL+GFn6idWk9EgM54t/RFy
	 dUmtSeT9kwczYUP5uRBDRb/ebMznpS5VLeCH01JTbhB3NDJxhpA8EoG7UmRz2ca77r
	 vKm0tCitpuAzQ==
Date: Wed, 20 May 2026 18:36:07 +0800
From: Zorro Lang <zlang@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Zirong Lang <zlang@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfstests: disable generic/003 for HFS file system
Message-ID: <ag2M-ndyIT4Fk5bv@zlang-mailbox>
Mail-Followup-To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"frank.li@vivo.com" <frank.li@vivo.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Zirong Lang <zlang@redhat.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260514200004.354432-2-slava@dubeyko.com>
 <agmF-PIo1yRu9KHK@zlang-mailbox>
 <3ed32501c3b9af0370cb749a0a7888c4c68d745a.camel@ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed32501c3b9af0370cb749a0a7888c4c68d745a.camel@ibm.com>

On Mon, May 18, 2026 at 06:27:52PM +0000, Viacheslav Dubeyko wrote:
> On Sun, 2026-05-17 at 17:38 +0800, Zorro Lang wrote:
> > On Thu, May 14, 2026 at 01:00:05PM -0700, Viacheslav Dubeyko wrote:
> > > HFS hasn't any field in on-disk layout that can keep
> > > the file/folder access times (atime):
> > > 
> > > /* The catalog record for a file */
> > > struct hfs_cat_file {
> > >         s8 type;                        /* The type of entry */
> > >         u8 reserved;
> > >         u8 Flags;                       /* Flags such as read-only */
> > >         s8 Typ;                         /* file version number = 0 */
> > >         struct hfs_finfo UsrWds;        /* data used by the Finder */
> > >         __be32 FlNum;                   /* The CNID */
> > >         __be16 StBlk;                   /* obsolete */
> > >         __be32 LgLen;                   /* The logical EOF of the data fork*/
> > >         __be32 PyLen;                   /* The physical EOF of the data fork */
> > >         __be16 RStBlk;                  /* obsolete */
> > >         __be32 RLgLen;                  /* The logical EOF of the rsrc fork */
> > >         __be32 RPyLen;                  /* The physical EOF of the rsrc fork */
> > >         __be32 CrDat;                   /* The creation date */
> > >         __be32 MdDat;                   /* The modified date */
> > >         __be32 BkDat;                   /* The last backup date */
> > >         struct hfs_fxinfo FndrInfo;     /* more data for the Finder */
> > >         __be16 ClpSize;                 /* number of bytes to allocate
> > >                                            when extending files */
> > >         hfs_extent_rec ExtRec;          /* first extent record
> > >                                            for the data fork */
> > >         hfs_extent_rec RExtRec;         /* first extent record
> > >                                            for the resource fork */
> > >         u32 Resrv;                      /* reserved by Apple */
> > > } __packed;
> > > 
> > > This patch disable the generic/003 test-case for
> > > HFS file system.
> > > 
> > > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > cc: Yangtao Li <frank.li@vivo.com>
> > > cc: linux-fsdevel@vger.kernel.org
> > > cc: fstests@vger.kernel.org
> > > ---
> > >  common/rc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 5fe44e21..b897ef0b 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4559,6 +4559,9 @@ _require_atime()
> > >  	ceph|ceph-fuse)
> > >  		_notrun "atime not maintained by $FSTYP"
> > >  		;;
> > > +	hfs)
> > > +		_notrun "atime not maintained by $FSTYP"
> > 
> > Good to me, thanks! But how about grouping "hfs" together with "ceph|ceph-fuse",
> > since you want them to share the same _notrun output message. I can help to
> > change that when I merge it if you agree. Or you can send v2 with my:
> > 
> > Reviewed-by: Zorro Lang <zlang@kernel.org>
> > 
> > Currently we have two kinds of *output* in _require_atime:
> > 
> >         nfs|afs|cifs|virtiofs)
> >                 _notrun "atime related mount options have no effect on $FSTYP"
> >                 ;;
> >         ceph|ceph-fuse)
> >                 _notrun "atime not maintained by $FSTYP"
> >                 ;;
> > 
> > But the boundary between them seems a bit fuzzy. If the struct supports
> > atime-related fields, but the mount options don't work or are highly
> > discouraged, it should fall into the first category (like NFS and CIFS).
> > If the struct itself doesn't have atime, it should be the second category
> > (like Ceph and HFS).
> > 
> > But looking at it this way, AFS's struct afs_file_status doesn't seem to
> > have anything related to atime either. Haha, it's getting a bit messy here.
> > 
> 
> I completely trust to your way of changing the patch. But if you need a reworked
> version of the patch, then I am ready to rework it. But, I slightly lost the
> point which modification should be done, finally. :)

No worries at all, I might have caused some confusion. I have already Acked this
patch. For this patch itself, you don’t need to rework anything, I will handle a
minor clean-up during merge, to group hfs and ceph|ceph-fuse together :-D

As for my question about AFS, I was just curious and wanted to have a quick side
discussion; it has nothing to do with this patch and we can discuss it separately.

Thanks for your patch!

> 
> Thanks,
> Slava.
