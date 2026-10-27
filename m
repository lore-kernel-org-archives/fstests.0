Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793097777;
	b=cD7TGQBLYqwCxfTUwjBi4mMqKnQkZkBNaMUPsq4kETFafVLS+RKYER+TUzpzoRkWDb4D
	 63Y1zJRgbXr1b+5awdjhE7bP8b0SrH85kVCwh5qtKxn0MeIVEMsHfS1HeLNMESXhDpXln
	 e3B9kJE7i1IvS3m3ujIoVMWGH70rXYxsBbdbz1F1X2Osg7iF3BJ7N+MoMufuLwkIvZLtf
	 hFIR+/i5vZZDYCk7XMdnp+3z3yyYWxiRAeYC0cYEDLviWfEfAjksmtywgAqYGASQGQs4h
	 47IGZ1hllFUu/7bCjDyCN/A51HAeN5hHGbEnLgwkR6BYqZWY8dR976B0ZAUgO4Qp0Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097777;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oWRDr+KAMvVRHygSDXOz09JvNbBoKbMMPJD2aMVGoPE=;
	b=KS5jSSvaqWgvrmRtIMWUAsM5kcDB75ppy8ZIusOxL96K0nEFpaDgit8QZFez16tpk46v
	 d/GlvxGsaI4eYE+Q94Q6QEESS5BrDJx/bzvIzDk4LdUU2WV5y+gFbwTfX1VOE/LgTDdy6
	 +Sgg6O0iR2l6vlaRcEdXW+zSOaKsVXtu0AMPzzosjWuQRvb/h0zgcSxQLpz9ml3LDbNbZ
	 xBaKJnMaRZ+CDVQrJwbSsDOKGwiCUsbkq7Y1Ms95uZ1wd/wuKFicmwqw8ozz8QvkI8IKB
	 yjPC5EWR8Lp/yNAJAk9e5PVovuJilTz4HW/9lSTovmpCyJ5isdEYgmmm7QA6gKvK6Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpE6OV2P;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pBDLPLP5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69FA606A31A
	for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 10:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E69FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpE6OV2P;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pBDLPLP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793097775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWRDr+KAMvVRHygSDXOz09JvNbBoKbMMPJD2aMVGoPE=;
	b=XpE6OV2PSsipHaXnDF8PVghHQeBlcndGBsVY+ZPtr6XLQpd2UoSZys7aegVEIn4FNC5MEd
	r7eIKR2xY3+wITy5jEKKXuRUST1uWEdk05I/VjtE9pbAHdIBLvHl784jJuciZ5HZq7DOMi
	B1t015zQqYWD4yCQYUgoXeQswALY1AY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-R5suW7_dMlauI_Y6e3HgVw-1; Tue, 27 Oct 2026 06:42:48 -0400
X-MC-Unique: R5suW7_dMlauI_Y6e3HgVw-1
X-Mimecast-MFC-AGG-ID: R5suW7_dMlauI_Y6e3HgVw_1793097768
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-547ae874949so6483928b6e.2
        for <fstests@vger.kernel.org>; Tue, 27 Oct 2026 03:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793097768; cv=none;
        d=google.com; s=arc-20260327;
        b=SWIIH2h3nyyank8Q8rfKanaE09zFLZJnDzHkfE5jZowiUNdmlvn0l5yuoDt+TOJBHo
         FA/Cb265joXCFb9Qc8lRkz0L9OrchSiTjpMqsgV86yc6ZRHcq+86uU8IYg5MEOUaQmKx
         nOg1/Z6Ms/lkGrqcQlwcjqGChM4fP46BH4ts3E8j5ZjMkhshqsx7upjudsA9d4rwmvqF
         cW2WWMNak7beMo6CeJmhZWzeodEbgbj+ZhwdoIqaNPHvIEAQ2Ig3Dyi28OOVVxjly57L
         AKKRb/rxwN92D8rvEZpj4e1bu3kD3ybKa+kY+hK2q5kGLEKfTcg4ecUn7TuK3ZHehpe5
         h5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWRDr+KAMvVRHygSDXOz09JvNbBoKbMMPJD2aMVGoPE=;
        fh=5MFEjP6H0+KA5mJkFeab7bBR96rW3JN+br8SLa5eIDo=;
        b=S9qBYnWhGcCHbMGE+NmMJa/ZJkwXKnNJFi5NlkqdANGzjK4eqbYN0klscoiQ8l+eEZ
         7q6q+kdwj7WCcliXUgd+T23ZGBwHOQdNpo7hbGiqWB/z1N3xSzANskQBv2gi2YYCSxNC
         TpaJh6JLkwcEhLqpSKKC4B49B7kOPYpXhVQ1ZGAh2DrjSauTb+XWLFh9cdYs60pB2jj4
         E8jCeR0zayBIK/F6odn/Wbu3im/kQOWEbq3WTUqCF3JRLvgQBTpCswhlU8+l1PLlm1OU
         5eI+TydyxlskbgP6mkKT/ZwAM27TVSQXSUUMAhmZpvj38IRuM6ZGb9wgw39eU4kZj4Iu
         WETw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793097768; x=1793702568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWRDr+KAMvVRHygSDXOz09JvNbBoKbMMPJD2aMVGoPE=;
        b=pBDLPLP5vkDXXYGXlt3cgXUdph7p80eUCSwvMVyRMltahYSOAu4rKDlX6IbH65PiFI
         ma5E6hQyoHLzZAaYQvHwzkiO61Aup7DJSw75OSRiiBa1mrCM40NHZ6DMYIkg7PjsPGqa
         ZtwmtkGSfSKDgitbLzCruZ9MnfxXQIdfCRDpmKNbrZjBbgL27+ZbSUzAhUw8Go0y/w5C
         914LgxmP+8JUmnaURlB58GmDtWU36znULmP5MLMw0fL0R2rLIsd6RxvkDmqjQW+b0DJa
         LuBmuhY73gg2IEc17AjLDo9YsZfeTr8TouK+ywedX3NgQBdTBCYSxOsMYxHTTGzOqJvc
         mDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097768; x=1793702568;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oWRDr+KAMvVRHygSDXOz09JvNbBoKbMMPJD2aMVGoPE=;
        b=Na8Sgiqzk5xP53SXxXuHZHvQxW0dSNueLvzLYcTcV/6xu1IWWac6yo1bV0KPqWFuyp
         7UAB4xA4rOcdHokjNLXt+S+51GNJe0OvfIiBcBC7qEBqBCZ+kgZyoHi8DbDWzJohU7MK
         2Y8zNKUm5SFd4ilh0YjVh1xjTMCGr3yjcxV0EiCc945RXOEXW9Qv6TmpUdB60wS9XQNC
         g2Aajke9LgenWker77mj2U0S2Nz2DMYPJcZNA863UPsXquhoW4ojn+c+8QhgiZcCIta1
         PSTE40g5wZ7BsROTPUZSvYmLHThwzy0xQtDO1yZydoc2b7PxOir0Frm/H/LAx1L6rhmP
         JVWg==
X-Forwarded-Encrypted: i=1; AKwUvBxbWi0D6w5z39fzpSBvDoM3yIlJy+kPdX6ib4GcfoJQHQ/+P7kZV69eW1yWZTPbgmDfIgLNq7OL@vger.kernel.org
X-Gm-Message-State: AFq9FYJbEdqmGETDb5PO7ZMDLZ3VKt2oxP/11siTXpE4S/EOHBvQvNpY
	GycI4cbZbbVn7iowbOgEwzJNBW6WC1o3LSTGnOV+SgT/LPs4MJ891iFy/dyXaoiO8JHA86qJO1L
	wr1/Hu44lQQ1TRgb9ijJMP17ctRihRWz3x+gOfdA3hdDdhoRGvoB7tmPNFxS4zLYNJz3KEiWknr
	l3ZTnFIv0EyThwaIwRTeRYsialLpskZBUF3g==
X-Gm-Gg: AYBFou3G98nr6q5Ki097xG/CpGKCO0AltkUw7YR2w4dIQMHwJqP90i8+/WB1EX+S5s5
	zvoBB974vvrxPILBFMU/nwiKkcmiANZCaiA3mx2sVaEaU344cdk9Dhvq4sNeudpxj2yoXc6/CCO
	TEIN7VDNGAi1nHMVnZTgwgJiS6PK9mPvHgrCJB1HLc9qjnqenXsIyqnA==
X-Received: by 2002:a05:6808:17a1:b0:4cb:818f:d573 with SMTP id 5614622812f47-55c00261961mr7000568b6e.27.1793097767610;
        Tue, 27 Oct 2026 03:42:47 -0700 (PDT)
X-Received: by 2002:a05:6808:17a1:b0:4cb:818f:d573 with SMTP id
 5614622812f47-55c00261961mr7000544b6e.27.1793097766983; Tue, 27 Oct 2026
 03:42:46 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016091628.295119-1-lherbolt@redhat.com> <auBcfVX2v_JOvr80@zlang-mailbox>
In-Reply-To: <auBcfVX2v_JOvr80@zlang-mailbox>
From: Lukas Herbolt <lherbolt@redhat.com>
Date: Tue, 27 Oct 2026 11:42:10 +0100
X-Gm-Features: AclHuK9MSXwvgxYFf3YhGWRJJLDXdetMaztjetQ_wSNhrDMYco3NKZc6wYbRQow
Message-ID: <CAM4Jq_748KsYMaGR=VCX9Z5zgQh2nXhvz5Rq64LDXT+xfxxzjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] xfs: add test for ENOSR/ENOSPC on DIO into delalloc extents
To: Lukas Herbolt <lherbolt@redhat.com>, fstests@vger.kernel.org, hch@lst.de, 
	linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:33=E2=80=AFAM Zorro Lang <zlang@kernel.org> wrote=
:
>
> On Fri, Oct 16, 2026 at 11:16:25AM +0200, Lukas Herbolt wrote:
> >   Test if a DIO extending write into a speculative delalloc region on a
> >   fragmented XFS filesystem does not trigger a dirty transaction cancel
> >   (-ENOSR) or return a spurious -ENOSPC.
> >
> >   With allocsize=3D128MB, a buffered write creates a large delalloc ext=
ent.
> >   A subsequent DIO write at i_size lands in the speculative prealloc
> >   region. On a fragmented filesystem, xfs_bmapi_write converts the
> >   delalloc starting from offset 0 but the allocation is too short to
> >   reach the DIO offset, causing either -ENOSR (dirty transaction cancel
> >   and filesystem shutdown) or -ENOSPC (wrong error from xfs_bmapi_write=
).
> >
> >   Assisted by LLM.
> >
> >   Fixed by kernel commits:
> >     2a9b99d45be0 xfs: pass the actual offset and len to xfs_bmapi_alloc=
ate
> >     21255afdd729 xfs: do not allocate the entire delalloc extent
> >     6773da870ab8 xfs: fix error returns from xfs_bmapi_write
> >
> > Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Lukas Herbolt <lherbolt@redhat.com>
> > ---
> >  .gitignore                 |   2 +
> >  src/Makefile               |   3 +-
> >  src/buffer_direct_io.c     | 154 ++++++++++++++++++++++++++++++++
> >  src/fragment_fs.c          | 101 +++++++++++++++++++++
> >  src/mix_buffer_direct_io.c | 175 +++++++++++++++++++++++++++++++++++++
> >  tests/xfs/842              |  63 +++++++++++++
> >  tests/xfs/842.out          |   2 +
> >  7 files changed, 499 insertions(+), 1 deletion(-)
> >  create mode 100644 src/buffer_direct_io.c
> >  create mode 100644 src/fragment_fs.c
> >  create mode 100644 src/mix_buffer_direct_io.c
> >  create mode 100755 tests/xfs/842
> >  create mode 100644 tests/xfs/842.out
> >
> > diff --git a/.gitignore b/.gitignore
> > index d52ba4ad3085..eafc36c7d8ab 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -217,6 +217,8 @@ tags
> >  /src/t_btrfs_received_uuid_ioctl
> >  /src/btrfs_ioctl
> >  /src/dio-read-into-mmap
> > +/src/buffer_direct_io
> > +/src/fragment_fs
>
> You're trying to add 3 *.c programs in this patch, there're only 2 lines.
> And ...
>
> >
> >  # Symlinked files
> >  /tests/generic/035.out
> > diff --git a/src/Makefile b/src/Makefile
> > index 0ff607ae1593..c8964a59a539 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -21,7 +21,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
> >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> >       readdir-while-renames dio-append-buf-fault dio-write-fsync-same-f=
d \
> > -     dio-writeback-race unlink-fsync truncate dio-read-into-mmap
> > +     dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
> > +     mix_buffer_direct_io fragment_fs
>
> ... there're only 2 too.
Sorry for that, I changed buffer_direct_io to mix_buffer_direct_io and
forgot to clean it up.
> >
> >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/buffer_direct_io.c b/src/buffer_direct_io.c
> > new file mode 100644
> > index 000000000000..01b19994a2e2
> > --- /dev/null
> > +++ b/src/buffer_direct_io.c
> > @@ -0,0 +1,154 @@
> > +/*
> > + * Mixer of buffered and direct IO originally written to test for XFS =
-ENOSPC
> > + * and -ENOSR dirty transaction cancel on fragmented filesystem.
> > + *
> > + * XFS notes:
> > + * Buffered write size.  With allocsize=3D128MB, the buffered write cr=
eates
> > + * a delalloc extent of [0, BUF_WRITE_SIZE + 128MB).  The DIO at i_siz=
e
> > + * is at file offset BUF_WRITE_SIZE.  xfs_bmapi_allocate (RHEL 8) star=
ts
> > + * the delalloc conversion from offset 0; the allocation must span
> > + * BUF_WRITE_SIZE/blocksize blocks in one contiguous extent to reach t=
he
> > + * DIO offset.  On a fragmented FS that's impossible =E2=80=94 but the=
 FS may
> > + * still have large free extents in metadata-sparse regions (20-40 MB =
is
> > + * common).  64 MB puts the DIO offset safely beyond those.
> > +
> > +
> > + *
> > + * Usage:
> > + *   ./mix_buffer_direct_io $SCRATCH_MNT
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <sys/stat.h>
> > +#include <sys/statvfs.h>
> > +
> > +#define BUF_WRITE_SIZE       (64 * 1024 * 1024)      /* 64 MB */
> > +
> > +/* DIO write size =E2=80=94 must be block-aligned */
> > +#define DIO_SIZE     4096
> > +
> > +static int attempt_trigger(const char *dir, int attempt)
> > +{
> > +     char filepath[4096];
> > +     char *wbuf;
> > +     void *dbuf;
> > +     int bfd, dfd, ret;
> > +
> > +     snprintf(filepath, sizeof(filepath), "%s/target_%d", dir, attempt=
);
> > +
> > +     wbuf =3D calloc(1, BUF_WRITE_SIZE);
> > +     if (!wbuf) {
> > +             perror("calloc");
> > +             return -1;
> > +     }
> > +
> > +     if (posix_memalign(&dbuf, DIO_SIZE, DIO_SIZE)) {
> > +             perror("posix_memalign");
> > +             free(wbuf);
> > +             return -1;
> > +     }
> > +     memset(dbuf, 0xbb, DIO_SIZE);
> > +
> > +     /*
> > +      * Open both fds up front. Keep the buffered fd open across the
> > +      * DIO write so close() can't trigger writeback that converts the
> > +      * delalloc before we hit it with DIO.
> > +      */
> > +     bfd =3D open(filepath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > +     if (bfd < 0) {
> > +             if (errno =3D=3D EIO || errno =3D=3D EROFS) {
> > +                     fprintf(stderr, "Filesystem shut down!\n");
> > +                     free(wbuf); free(dbuf);
> > +                     return 1;
> > +             }
> > +             perror("open for buffered write");
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     dfd =3D open(filepath, O_WRONLY | O_DIRECT);
> > +     if (dfd < 0) {
> > +             if (errno =3D=3D EIO || errno =3D=3D EROFS) {
> > +                     fprintf(stderr, "Filesystem shut down!\n");
> > +                     close(bfd);
> > +                     free(wbuf); free(dbuf);
> > +                     return 1;
> > +             }
> > +             perror("open for DIO");
> > +             close(bfd);
> > +             unlink(filepath);
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     /*
> > +      * Step 1: One buffered write.
> > +      * On XFS with  allocsize=3D128MB, this creates a delalloc extent=
 of
> > +      * [0, BUF_WRITE_SIZE + 128MB) but only [0, BUF_WRITE_SIZE) has p=
ages.
> > +      * The rest is speculative prealloc.
> > +      */
> > +     ret =3D pwrite(bfd, wbuf, BUF_WRITE_SIZE, 0);
> > +     if (ret < 0) {
> > +             if (errno =3D=3D ENOSPC) {
> > +                     fprintf(stderr, "attempt %d: ENOSPC on buffered w=
rite\n",
> > +                             attempt);
> > +                     close(dfd);
> > +                     close(bfd);
> > +                     unlink(filepath);
> > +                     free(wbuf); free(dbuf);
> > +                     return 0;
> > +             }
> > +             perror("buffered pwrite");
> > +             close(dfd);
> > +             close(bfd);
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     /*
> > +      * Step 2: DIO extending write at i_size.
> > +      *
> > +      * Offset BUF_WRITE_SIZE is within the speculative delalloc but h=
as no
> > +      * pages, so the DIO flush is a no-op. xfs_bmapi_write finds the
> > +      * delalloc starting at offset 0 and tries to convert from there.=
 On
> > +      * our fragmented FS the allocation is 1 block at file offset 0,
> > +      * nowhere near the DIO offset at block 256. Returns -ENOSPC or -=
ENOSR.
> > +      */
> > +     ret =3D pwrite(dfd, dbuf, DIO_SIZE, BUF_WRITE_SIZE);
> > +     if (ret < 0) {
> > +             fprintf(stderr, "DIO pwrite failed: %s\n", strerror(errno=
));
> > +             close(dfd);
> > +             close(bfd);
> > +             free(wbuf); free(dbuf);
> > +             return errno;
> > +     }
> > +     close(dfd);
> > +     close(bfd);
> > +     unlink(filepath);
> > +     free(wbuf);
> > +     free(dbuf);
> > +     return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     int i, ret;
> > +
> > +     if (argc !=3D 2) {
> > +             fprintf(stderr, "  %s <directory>\n", argv[0]);
> > +             return 1;
> > +     }
> > +
> > +     for (i =3D 0; i < 1000; i++) {
> > +             ret =3D attempt_trigger(argv[1], i);
> > +             if (ret !=3D 0)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > diff --git a/src/fragment_fs.c b/src/fragment_fs.c
> > new file mode 100644
> > index 000000000000..cee4edef73ff
> > --- /dev/null
> > +++ b/src/fragment_fs.c
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2026 Eric Sandeen, Lukas Herbolt
> > + */
> > +
> > +/*
> > + * Fragment filesystem by creating fixed-size files and then deleting
> > + * every n-th one.
> > + *
> > + * Usage:
> > + *   fragment_fs <directory> <prefix> <file size> <delete every n-th f=
ile>
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <sys/statvfs.h>
> > +
> > +static int fragment_fs(const char *dir, const char *prefix,
> > +                    off_t size, int delete_nth)
> > +{
> > +     char path[4096];
> > +     int i, fd;
> > +     int created =3D 0;
> > +
> > +     fprintf(stderr, "Fragmenting filesystem (filling to ENOSPC)...\n"=
);
> > +
> > +     for (i =3D 0; ; i++) {
> > +             snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i=
);
> > +             fd =3D open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > +             if (fd < 0) {
> > +                     if (errno =3D=3D ENOSPC)
> > +                             break;
> > +                     perror("open frag file");
> > +                     return -1;
> > +             }
> > +             if (fallocate(fd, 0, 0, size) < 0) {
> > +                     close(fd);
> > +                     unlink(path);
> > +                     if (errno =3D=3D ENOSPC)
> > +                             break;
> > +                     perror("fallocate frag file");
> > +                     return -1;
> > +             }
> > +             close(fd);
> > +             created++;
> > +     }
> > +     fprintf(stderr, "Created %d files\n", created);
> > +
> > +     fprintf(stderr, "Deleting every %d-th file...\n", delete_nth);
> > +     for (i =3D 0; i < created; i +=3D delete_nth) {
> > +             snprintf(path, sizeof(path), "%s/%s_%06d", dir, prefix, i=
);
> > +             unlink(path);
> > +     }
> > +     sync();
> > +
> > +     {
> > +             struct statvfs st;
> > +             if (statvfs(dir, &st) =3D=3D 0) {
> > +                     unsigned long free_mb =3D (st.f_bfree * st.f_bsiz=
e)
> > +                                             / (1024 * 1024);
> > +                     fprintf(stderr,
> > +                             "%d files remain, ~%lu MB free\n",
> > +                             created - created / delete_nth, free_mb);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     off_t file_size;
> > +     int delete_nth;
> > +
> > +     if (argc !=3D 5) {
> > +             fprintf(stderr,
> > +                     "Usage: %s <directory> <prefix> <file_size> <dele=
te_every_nth>\n",
> > +                     argv[0]);
> > +             return 1;
> > +     }
> > +
> > +     file_size =3D strtoll(argv[3], NULL, 0);
> > +     if (file_size <=3D 0) {
> > +             fprintf(stderr, "Invalid file size: %s\n", argv[3]);
> > +             return 1;
> > +     }
> > +
> > +     delete_nth =3D atoi(argv[4]);
> > +     if (delete_nth < 2) {
> > +             fprintf(stderr, "delete_every_nth must be >=3D 2\n");
> > +             return 1;
> > +     }
> > +
> > +     if (fragment_fs(argv[1], argv[2], file_size, delete_nth) < 0)
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > diff --git a/src/mix_buffer_direct_io.c b/src/mix_buffer_direct_io.c
> > new file mode 100644
> > index 000000000000..0af227a7c9f0
> > --- /dev/null
> > +++ b/src/mix_buffer_direct_io.c
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2026 Eric Sandeen, Lukas Herbolt
> > + */
> > +
> > +/*
> > + * Mix buffered and direct IO originally written to test for XFS -ENOS=
PC
> > + * and -ENOSR dirty transaction cancel on fragmented filesystem.
> > + *
> > + * XFS notes:
> > + * Buffered write size. With allocsize=3D128MB, the buffered write cre=
ates
> > + * a delalloc extent of [0, buf_write_size + 128MB).  The DIO at i_siz=
e
> > + * is at file offset buf_write_size.  xfs_bmapi_allocate (RHEL 8) star=
ts
> > + * the delalloc conversion from offset 0; the allocation must span
> > + * buf_write_size/blocksize blocks in one contiguous extent to reach t=
he
> > + * DIO offset.  On a fragmented FS that's impossible =E2=80=94 but the=
 FS may
> > + * still have large free extents in metadata-sparse regions (20-40 MB =
is
> > + * common).  64 MB puts the DIO offset safely beyond those.
> > + *
> > + * Usage:
> > + *   ./mix_buffer_direct_io <dir> [buf_write_size] [dio_size]
> > + *
> > + *   buf_write_size  Buffered write size in bytes (default 67108864 / =
64 MB)
> > + *   dio_size        DIO write size in bytes (default 4096), must be
> > + *                   block-aligned
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +
> > +static int attempt_trigger(const char *dir, int attempt,
> > +                        off_t buf_write_size, size_t dio_size)
> > +{
> > +     char filepath[4096];
> > +     char *wbuf;
> > +     void *dbuf;
> > +     int bfd, dfd, ret;
> > +
> > +     snprintf(filepath, sizeof(filepath), "%s/target_%d", dir, attempt=
);
> > +
> > +     wbuf =3D calloc(1, buf_write_size);
> > +     if (!wbuf) {
> > +             perror("calloc");
> > +             return -1;
> > +     }
> > +
> > +     if (posix_memalign(&dbuf, dio_size, dio_size)) {
> > +             perror("posix_memalign");
> > +             free(wbuf);
> > +             return -1;
> > +     }
> > +     memset(dbuf, 0xbb, dio_size);
> > +
> > +     /*
> > +      * Open both fds up front. Keep the buffered fd open across the
> > +      * DIO write so close() can't trigger writeback that converts the
> > +      * delalloc before we hit it with DIO.
> > +      */
> > +     bfd =3D open(filepath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > +     if (bfd < 0) {
> > +             if (errno =3D=3D EIO || errno =3D=3D EROFS) {
> > +                     fprintf(stderr, "Filesystem shut down!\n");
> > +                     free(wbuf); free(dbuf);
> > +                     return 1;
> > +             }
> > +             perror("open for buffered write");
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     dfd =3D open(filepath, O_WRONLY | O_DIRECT);
> > +     if (dfd < 0) {
> > +             if (errno =3D=3D EIO || errno =3D=3D EROFS) {
> > +                     fprintf(stderr, "Filesystem shut down!\n");
> > +                     close(bfd);
> > +                     free(wbuf); free(dbuf);
> > +                     return 1;
> > +             }
> > +             perror("open for DIO");
> > +             close(bfd);
> > +             unlink(filepath);
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     /*
> > +      * Step 1: One buffered write.
> > +      * On XFS with  allocsize=3D128MB, this creates a delalloc extent=
 of
> > +      * [0, buf_write_size + 128MB) but only [0, buf_write_size) has p=
ages.
> > +      * The rest is speculative prealloc.
> > +      */
> > +     ret =3D pwrite(bfd, wbuf, buf_write_size, 0);
> > +     if (ret < 0) {
> > +             if (errno =3D=3D ENOSPC) {
> > +                     fprintf(stderr, "attempt %d: ENOSPC on buffered w=
rite\n",
> > +                             attempt);
> > +                     close(dfd);
> > +                     close(bfd);
> > +                     unlink(filepath);
> > +                     free(wbuf); free(dbuf);
> > +                     return 0;
> > +             }
> > +             perror("buffered pwrite");
> > +             close(dfd);
> > +             close(bfd);
> > +             free(wbuf); free(dbuf);
> > +             return -1;
> > +     }
> > +
> > +     /*
> > +      * Step 2: DIO extending write at i_size.
> > +      *
> > +      * Offset buf_write_size is within the speculative delalloc but h=
as no
> > +      * pages, so the DIO flush is a no-op. xfs_bmapi_write finds the
> > +      * delalloc starting at offset 0 and tries to convert from there.=
 On
> > +      * our fragmented FS the allocation is 1 block at file offset 0,
> > +      * nowhere near the DIO offset at block 256. Returns -ENOSPC or -=
ENOSR.
> > +      */
> > +     ret =3D pwrite(dfd, dbuf, dio_size, buf_write_size);
> > +     if (ret < 0) {
> > +             fprintf(stderr, "DIO pwrite failed: %s\n", strerror(errno=
));
> > +             close(dfd);
> > +             close(bfd);
> > +             free(wbuf); free(dbuf);
> > +             return errno;
> > +     }
> > +     close(dfd);
> > +     close(bfd);
> > +     unlink(filepath);
> > +     free(wbuf);
> > +     free(dbuf);
> > +     return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     off_t buf_write_size =3D 64 * 1024 * 1024;
> > +     size_t dio_size =3D 4096;
> > +     int i, ret;
> > +
> > +     if (argc < 2 || argc > 4) {
> > +             fprintf(stderr,
> > +                     "Usage: %s <dir> [buf_write_size] [dio_size]\n",
> > +                     argv[0]);
> > +             return 1;
> > +     }
> > +
> > +     if (argc >=3D 3) {
> > +             buf_write_size =3D strtoll(argv[2], NULL, 0);
> > +             if (buf_write_size <=3D 0) {
> > +                     fprintf(stderr, "Invalid buf_write_size: %s\n",
> > +                             argv[2]);
> > +                     return 1;
> > +             }
> > +     }
> > +     if (argc >=3D 4) {
> > +             dio_size =3D strtoul(argv[3], NULL, 0);
> > +             if (dio_size =3D=3D 0 || dio_size % 512) {
> > +                     fprintf(stderr, "Invalid dio_size: %s\n", argv[3]=
);
> > +                     return 1;
> > +             }
> > +     }
> > +
> > +     for (i =3D 0; i < 1000; i++) {
> > +             ret =3D attempt_trigger(argv[1], i,
> > +                                   buf_write_size, dio_size);
> > +             if (ret !=3D 0)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > diff --git a/tests/xfs/842 b/tests/xfs/842
> > new file mode 100755
> > index 000000000000..b2b2f7c493e7
> > --- /dev/null
> > +++ b/tests/xfs/842
> > @@ -0,0 +1,63 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2026 Lukas Herbolt.  All Rights Reserved.
> > +#
> > +# FS QA Test 842
> > +#
> > +# Regression test for XFS -ENOSR dirty transaction cancel during DIO
> > +# write into a speculative delalloc region on a fragmented filesystem.
> > +# With allocsize=3D128MB, a buffered write creates a large delalloc ex=
tent.
> > +# A subsequent DIO extending write at i_size triggers xfs_bmapi_write =
to
> > +# convert the delalloc from offset 0; on a fragmented FS the allocatio=
n
> > +# is too short to reach the DIO offset, returning -ENOSR and cancellin=
g
> > +# a dirty transaction, which shuts down the filesystem.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto enospc
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -r -f $tmp.*
>
> This _cleanup does same thing with default _cleanup, so we can remove it.
>
> > +}
> > +
> > +_require_test
> > +_require_scratch
> > +_require_test_program "fragment_fs"
> > +_require_test_program "buffer_direct_io"
> > +
> > +_scratch_mkfs_sized $((1<<30)) > "$seqres.full" 2>&1
> > +_scratch_mount -o allocsize=3D131072k >> "$seqres.full" 2>&1
> > +
> > +src/fragment_fs $SCRATCH_MNT frag 4096 2 >> "$seqres.full" 2>&1
> > +src/buffer_direct_io $SCRATCH_MNT >> "$seqres.full" 2>&1
> > +RET=3D$?
> > +
> > +_dmesg_since_test_start | grep -q "detected at xfs_trans_cancel"
> > +DMESG_CHECK=3D$?
>
> Can we just do:
>   _check_dmesg_for "detected at xfs_trans_cancel" || echo "xxxx" ?
>
> > +
> > +if [ $RET -eq 5 -a $DMESG_CHECK -eq 0 ]; then
> > +     _fixed_by_kernel_commit 2a9b99d45be0 \
> > +             "xfs: pass the actual offset and len to xfs_bmapi_allocat=
e"
> > +     _fixed_by_kernel_commit 21255afdd729 \
> > +             "xfs: do not allocate the entire delalloc extent"
> > +     _fail "ENOSR dirty transaction cancel detected (ret=3D$RET)"
> > +
> > +elif [ $RET -eq 28 ]; then
> > +     _fixed_by_kernel_commit 2a9b99d45be0 \
> > +             "xfs: pass the actual offset and len to xfs_bmapi_allocat=
e"
> > +     _fixed_by_kernel_commit 21255afdd729 \
> > +             "xfs: do not allocate the entire delalloc extent"
> > +     _fixed_by_kernel_commit 6773da870ab8 \
> > +             "xfs: fix error returns from xfs_bmapi_write"
>
> We usually do _fixed_by_kernel_commit as hints before the test starts. If=
 you
> want to explain which hints correspond to different test results, I think
> adding a few comments should be enough.
>
> > +     _fail "ENOSPC returned from xfs_bmapi_write (ret=3D$RET)"
> > +
> > +elif [ $RET -eq 0 ]; then
> > +     echo "Silence is golden"
>
> Just print this line at the end of this case.
>
> > +else
> > +     _fail "Unknown error: src/buffer_direct_io error code $RET"
> > +fi
>
> The logic here is a bit messy. It might be better to let the .c test prin=
t
> different outputs to fail the golden image. Better to clean this up to
> keep the code straightforward.
>
Ok noted, I will rework it and clean it up.
> > +
> > +# success, all done
> > +status=3D0
> > +exit
>
> _exit 0
>
> > diff --git a/tests/xfs/842.out b/tests/xfs/842.out
> > new file mode 100644
> > index 000000000000..643d05289a33
> > --- /dev/null
> > +++ b/tests/xfs/842.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 842
> > +Silence is golden
> > --
> > 2.56.0
> >
>
thanks for the comments

--=20
Lukas Herbolt
SSME
Red Hat

