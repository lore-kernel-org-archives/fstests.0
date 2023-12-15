Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8DD27F
	for <fstests@vger.kernel.org>; Fri, 15 Dec 2023 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAmO2XFd"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-77f58040770so29415185a.2
        for <fstests@vger.kernel.org>; Thu, 14 Dec 2023 22:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702621284; x=1703226084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6Ej4p2VxZXmDGNrPTEiu0fO5tRSyp5RDPM84WMGdmw=;
        b=CAmO2XFdX9yHzaPKDrRV3lr6Neglq8MOfMriFMauca7Lh3U2QPmWZ2OUsU18oYjy/A
         5aL14FB0VzRUNtm3pxdlxbqL3ENmYuVt+Z6LsIW8waCuw4WPCrj3Eu7GDnfXi3lRSP2i
         bTIX8CW0QaiiN5qTFpSmDwyUBahX61FxW3X4sAJP641SyxqI1gf7+6pz4UwHQTdWOPzf
         fWs4HroOjPOBkKr/5f5PYYAyDrJoJgXc/EQPXFwatfNKWmRl4kWVGvQo5aBvUwkPCKaj
         EG8l9T7jaR8DlBI7FLEwPFezEnpjxLvOIszPhHqo9/CDjGYcuAWpIOZbzV9HEfmZuPvN
         OBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702621284; x=1703226084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6Ej4p2VxZXmDGNrPTEiu0fO5tRSyp5RDPM84WMGdmw=;
        b=TfD48PfNwfV0QMdw9oNy1AEW5qOYLLtA7VkIqLZ9+niPSngnhYYyU/Yesyf2nghbU/
         ovG/NzV5quDeDm1agUfbUGt6fj4T4M/ZDYrPGy7CDbkegLqhSXYwRgfWqlwZquB4TobD
         Dt9peWqpJY4JL5nPGsXxNVYr4FIv4qh+Dg5iEJSSoCs+EF4OESlxBDRoM0KKn9EJ5hNc
         CIozbfQ5fX2/+qyUK9Ne+9djJAoEPc4kKhAsLXCDiTyfDFU1MN+0zbycXTOeYqJkUsLR
         jyEx5TO7nLwrmX8+h5eLY2WOF5aUnsDKD3o6FlEXY4PgEKzxRnqqhTBDyxwlgn2ooQuP
         Evlw==
X-Gm-Message-State: AOJu0Yw00+WxTSttGM6MeU8f7fmEtcez45cCG0ktFH6i2U3A4UbpCpMo
	l2TO/ldalaoBY46XJebvrdw5UuctiJJEiFtXLZESFSEv
X-Google-Smtp-Source: AGHT+IHb2V+U45PRVy69Qrs9EWjt+PCw6p3maq/piMpXUIwjyiu97A0wIL6hLBhRHvjrT+bZ57MCm00sICnZCfvc/XI=
X-Received: by 2002:a05:620a:28c2:b0:77f:3db5:7b69 with SMTP id
 l2-20020a05620a28c200b0077f3db57b69mr14022032qkp.32.1702621284523; Thu, 14
 Dec 2023 22:21:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213092043.1621684-1-jencce.kernel@gmail.com> <20231213153431.eu4ii7ljmssgynyl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20231213153431.eu4ii7ljmssgynyl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 15 Dec 2023 14:21:13 +0800
Message-ID: <CADJHv_t4fzLjNBfabTSVgSW8QAjq7V=s_wW7cOJ8UPo+t9vdNw@mail.gmail.com>
Subject: Re: [PATCH] generic/new: drop caches while freeze
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zorro,

On Wed, Dec 13, 2023 at 11:34=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrot=
e:
>
> On Wed, Dec 13, 2023 at 05:20:43PM +0800, Murphy Zhou wrote:
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  tests/generic/734     | 34 ++++++++++++++++++++++++++++++++++
>
> Hi Murphy,
>
>
> Thanks for this new test. Sorry that g/734 has been taken last weekend,
> please rebase to the latest for-next branch.

Got it.
>
> >  tests/generic/734.out |  2 ++
> >  2 files changed, 36 insertions(+)
> >  create mode 100755 tests/generic/734
> >  create mode 100644 tests/generic/734.out
> >
> > diff --git a/tests/generic/734 b/tests/generic/734
> > new file mode 100755
> > index 00000000..8ca91930
> > --- /dev/null
> > +++ b/tests/generic/734
> > @@ -0,0 +1,34 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test 734
> > +#
> > +# Test possible deadlock of umount and reclaim memory
> > +# when there are EOF blocks in files.
>
> Is there a known bug fix for this case? If yes, please specify that by:
> "_fixed_by_kernel_commit xxxxxxxxxx xxxxxxxxxxxxxxxx".

Maybe a patchset but I'm not sure of it. In this situation I think
we can skip this part?

>
> > +#
> > +. ./common/preamble
> > +_begin_fstest freeze auto quick
> > +
> > +_supported_fs generic
> > +_require_scratch
>
> This's a geneirc case, not all fs support fsfreeze, so ...
> _require_freeze

Got it.
>
> And ...
>
> _scratch_mkfs >> $seqres.full ??
> _scratch_mount ??

OK.
>
> > +
> > +$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full
>
> Could you explain why there're two duplicated lines below? If it's intend=
ed,
> better to have a comment to explain why do it twice (not once or more tim=
es).

OK.
>
> > +cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
> > +cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
> > +
> > +sync
> > +
> > +fsfreeze -f $SCRATCH_MNT
>
> All cases in fstests do fs freeze by xfs_freeze. If there's not special
> reason, better to keep consistency. Due to the _require_freeze checks
> that too.

OK.
>
> > +
> > +# This will hang if bug reproduces
> > +echo 3 > /proc/sys/vm/drop_caches &
>
> I'm wondering, if the data in cache has been written back and been cleare=
d
> before fsfreeze or this step, what will happen? If the cache data is nece=
ssary,
> should we load/read more data/files to provide that?

Agree. I'll add more files.
>
> > +
> > +# Manually unfreeze after a while
> > +sleep 5
> > +fsfreeze -u $SCRATCH_MNT
> > +
> > +wait
>
> As there's a fs freeze in this case, so we'd better to do a "forced" unfr=
eeze
> in _cleanup, to make sure the fs will be unfreezed 100%, no matter what. =
So
> you can move these two lines to _cleanup.

Good idea!

Thanks for reviewing!

Murphy
>
> > +# success, all done
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/734.out b/tests/generic/734.out
> > new file mode 100644
> > index 00000000..4299839b
> > --- /dev/null
> > +++ b/tests/generic/734.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 734
> > +Silence is golden
> > --
> > 2.31.1
> >
> >
>
