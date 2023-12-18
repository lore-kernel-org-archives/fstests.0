Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374575D723
	for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E71H4rH4"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so2940699b6e.2
        for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702924087; x=1703528887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCOVd7/LWlN2jz3Y3mNfBJd+MXrLX2lVWBygaMywl0o=;
        b=E71H4rH4DXc6BmgCQHfGi6O/ZVqeepQf++RX9bq47XXDrbx/n1YM4k+ITuEd4CL5Ur
         lH10V9DNrgLiOeJfJ8kQE5nc3G3rF9fVBz2EqgOIjAdUwHIuewEbwYzxaklkcN8ypcXG
         AYBoxEMT9ISab4fdEhLpjHKibhZK/eW3gH0++1LIchfzCBenH6r6VTqX0GmkTLC0FtUW
         s6A01UPqU0o/7jbIiYh681hussiGi8jvrccASbuVe6e6+oy534+1Kmr/C9SE6XOB6cUp
         P+rflx5ucDApp2Ldnypl635ZtFC3mMkwYAdf3nHrbaZfQuX8rffdtNeNXoqnAEkZVSyH
         E1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702924087; x=1703528887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCOVd7/LWlN2jz3Y3mNfBJd+MXrLX2lVWBygaMywl0o=;
        b=QSxBxcPbwZ6giwOjrQ3RNJk01jIFouycozyjES5klPUffyZSLw724EghBrorAa8UYl
         3LBkkwcSx2HPnUEHMf8QH/F/wdvYvOFj9PyrV7sPMza8lqvGDTRuhxbp1ofkx8tnrwSr
         MDsLpXXVn9ks6baXaj7NvYmtzWr59irjKOfnNsea0zHrmBJMsUvTX7MdM0FGqKHvVWcr
         eIgr6+qkWBln1NA2nLhCaGLl1JtslP88cDe7uZ705UdCx8vHGKobzbJyL8nqKIoWmMds
         nMrW9feUREh6u6B8SFn5aHYYn3hKkboCXyJuLkoKSrMf+XeNcotwH9N6441ONqcFV4Ga
         aVbA==
X-Gm-Message-State: AOJu0YzUYLX6V4BpePPmvMo2zP4soMK2lPz/Yvn4/FQ57HeJcLOE8rdG
	KpVeAUEdplPcex8udgA0yKy7cyixCJFT72CH7enDA3nle2Rt8T+H
X-Google-Smtp-Source: AGHT+IGqZ0YjxhNzqK5NWdRTWkRQ8wMVDiTLnUTB7fxK+u0lMO4hBBM52kP/dqS8wx92zR98WCbza6/Oxa6PLM7hijQ=
X-Received: by 2002:a05:6808:13c3:b0:3b9:fc7c:b585 with SMTP id
 d3-20020a05680813c300b003b9fc7cb585mr19875294oiw.32.1702924087176; Mon, 18
 Dec 2023 10:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN_LGv2UUOZvxN6w83tLudPZ5O9VPN0aJVDJay4rJDsvtcn29Q@mail.gmail.com>
 <20231217210053.9180-1-patrakov@gmail.com> <20231218174509.GE36211@frogsfrogsfrogs>
In-Reply-To: <20231218174509.GE36211@frogsfrogsfrogs>
From: "Alexander E. Patrakov" <patrakov@gmail.com>
Date: Tue, 19 Dec 2023 02:27:40 +0800
Message-ID: <CAN_LGv2u5qRq_Zmp+qPGXz-PXdO7Bu33CKn+ycmQX1dzbDRFvw@mail.gmail.com>
Subject: Re: [PATCH v2] _require_sparse_files: add a safeguard against media wearout
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Darrick, and thanks for the feedback.

On Tue, Dec 19, 2023 at 1:45=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Dec 18, 2023 at 05:00:53AM +0800, Alexander Patrakov wrote:
> > _require_sparse_files is implemented as a list of filesystems known not=
 to
> > support sparse files, and therefore it misses some cases.
> >
> > However, if sparse files do not work as expected during a test, the ris=
k
> > is that the test will write out to the disk all the zeros that would
> > normally be unwritten. This amounts to at least 4 TB for the generic/12=
9
> > test, and therefore there is a significant media wearout concern here.
> >
> > Adding more filesystems to the list of exclusions would not scale and
> > would not work anyway because CIFS backed by SAMBA is safe, while CIFS
> > backed by Windows Server 2022 is not.
> >
> > In other words, Windows reserves the right to sometimes (!) ignore our
> > intent to create a sparse file.
> >
> > More discussion: https://lore.kernel.org/fstests/20231206184759.GA39640=
19@frogsfrogsfrogs/T/#t
> >
> > Mitigate this risk by doing a small-scale test that reliably triggers
> > Windows misbehavior and checking if the resulting file ends up being
> > not sufficiently sparse.
> >
> > Signed-off-by: Alexander Patrakov <patrakov@gmail.com>
> > ---
> >  common/rc | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index cc92fe06..5d27602a 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2871,6 +2871,12 @@ _require_fs_space()
> >  # Check if the filesystem supports sparse files.
> >  #
> >  # Unfortunately there is no better way to do this than a manual black =
list.
>
> FWIW if the truncate/write/nblocks check strategy below can be made more
> general, then the comment above (and the FSTYP-filtering) become
> unnecessary, right?

I think so. I will retest with exfat and hfsplus, and, if their
failures are caught by the code that I added, I will delete the black
list.

>
> > +# However, letting tests expand all the holes and write terabytes of z=
eros to
> > +# the media is also not acceptable due to wearout concerns.
> > +#
> > +# Note: even though CIFS supports sparse files, this test will mark it=
 as
> > +# failing the requirement if we can coax the server into allocating an=
d writing
> > +# the ranges where holes are expected. This happens with Windows serve=
rs.
> >  #
> >  _require_sparse_files()
> >  {
> > @@ -2881,6 +2887,23 @@ _require_sparse_files()
> >      *)
> >          ;;
> >      esac
> > +
> > +    local testfile=3D"$TEST_DIR/$$.sparsefiletest"
> > +    rm -f "$testfile"
> > +
> > +    # A small-scale version of looptest - known to trigger Microsoft S=
MB server
> > +    # into the decision to write zeros to the disk. Also creates a non=
-sparse file
> > +    # on vfat.
> > +    # See also the discussion at https://lore.kernel.org/fstests/20231=
206184759.GA3964019@frogsfrogsfrogs/T/#t
> > +    $XFS_IO_PROG -f \
> > +     -c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 102400 102400' \
> > +     -c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 204800 102400' \
> > +     -c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 307200 102400' \
> > +     -c 'truncate 0' -c 'pwrite -b 102400 -S 0x61 409600 102400' "$tes=
tfile" >/dev/null
> > +    resulting_file_size_kb=3D$( du -sk "$testfile" | cut -f 1 )
> > +    rm -f "$testfile"
> > +    [ $resulting_file_size_kb -ge 300 ] && \
>
> I might be missing something here because I've long forgotten how CIFS
> and Windows work, but -- why is it necessary to truncate and write past
> eof four times?  Won't the truncates free all the blocks associated with
> the file?

No, Windows has special not-fully-understood logic (or maybe a race)
here. If I leave only the last truncate/pwrite pair, Windows
successfully makes a sparse file here, and then writes multiple
terabytes of real zeros during generic/129, which is what I am trying
to avoid.

In other words, CIFS mounts from Windows do support sparse files in
general, but this particular pattern of writes triggers the "your file
shall not be sparse" logic.

Let me quote from
https://learn.microsoft.com/en-us/windows/win32/api/winioctl/ni-winioctl-fs=
ctl_set_zero_data:

"""
If you use the FSCTL_SET_ZERO_DATA control code to write zeros (0) to
a non-sparse file, zeros (0) are written to the file. The system
allocates disk storage for all of the zero (0) range, which is
equivalent to using the WriteFile function to write zeros (0) to a
file.
"""

I guess here is what happens: initially the file is not created as a
sparse one (although I am not sure why - it would make more sense to
add another iteration at the beginning to ensure that). Then,
apparently, truncation to zero size does not reset the non-sparse
status. Then Windows sees that the file is not sparse, and so any
attempts to seek pas the EOF should, according to the Microsoft rule
quoted above, be translated to writing real zeros.

>
> Also, why isn't it sufficient to check that the du output doesn't exceed
> ~110K (adding 10% overhead)?

The overhead might be larger if the filesystem supports sparse files
but has, e.g., 64 KB native cluster size. Then a single badly-aligned
100 KB blob (which is what happens here) might actually occupy three
clusters and thus use 192 KB on the disk - which is still fine as long
as all preceding zeros are not written.

>
> > +     _notrun "Sparse files do not work as expected, skipping test due =
to media wearout concerns"
>
> I think the notrun message should be restricted to stating that sparse
> files do not work as expected -- the other callers aren't necessarily
> worried about wearout.

OK, the v3 will have this reworded.

>
> --D
>
> >  }
> >
> >  _require_debugfs()
> > --
> > 2.43.0
> >
> >

--=20
Alexander E. Patrakov
