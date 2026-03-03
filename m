Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395938A722
	for <fstests@vger.kernel.org>; Tue,  3 Mar 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529679; cv=pass; b=Ur8qkmqCdAtwmRXztPt0SVCAjYrs7IxLsh6TPCoOiz05VFPzL2H0sXZmMeaszSMmSJICuOyOOyXgCp/LTp92h7TnpFRY9bLaZJGGtFTDXCJd6dPvY8f+3qbb+uXAgQjWDNQalgrxlUKcR5SMfz1AkZEfVxKmU0ZY6gXlUspihYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529679; c=relaxed/simple;
	bh=bb64YLXIy3oPeHwsvS7m0P33nEAT9WuWSYWp276y4dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ+ioZtb09dVmTp0hu5UpgZxf+Bc85puvc63JOnNRZKyhd/8vAEEOegI1v+FdSDVLUixnbK0KbGJrroznlYxmMBGbKlpOCbiZbl5TerCJ574+yjzYMbpxWEjWJkX5YvRz27ujFRXmn9X3Q7FR48oAubUGNAxtFYOuUG2zirb/J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGuTpO3B; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGuTpO3B"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so746147766b.1
        for <fstests@vger.kernel.org>; Tue, 03 Mar 2026 01:21:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772529676; cv=none;
        d=google.com; s=arc-20240605;
        b=CHlGE5MY3/xqlRpfO0l8qWX9KxEN5qRfOyOMp5+lgnl411He8mP+BrP+bMI56KudBE
         88ZZaUK9zixPJP/VQqsXNfbzDeuPly4jnYgdo76Aan/EPe068ooGqC/V7Utk4z25c0tS
         1BRW3LLLkf8p6lV386Cw6HuWSqaDY2uoFJ6Wq1OsINn3Fx5ztEGt928amOU8mJijMcZs
         XOlW/OOO3AkGlBA3R1Z5EU5p3TBBj6b38bYfUXL0nVr3bwqlDcFZ7RShaWijBZ6/gWhg
         7N4biK2b3/0kTh8hhekxyRh5lcL7iU5uTqfjoDX4p3CryuZK5kBHmpYziX/nuPY3jyTc
         DCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        fh=i06gytkCiIVC2KLP6FQarEuUlYW/WZEz6O1Cx+n1o2A=;
        b=OeNarFCW1N6sO/6AlPE39AyvLbeGAI27S80sD2IocgKnL4k7ESfKLjIdgykfIyka+9
         HHLRcG7G9o/OIncLXdFxsqnj52M9BfV4Wia/cA7E47SG60icrgIWS9AmnLz7Tw+r5br6
         ZMOEfk4jlE0Hip8aRV7X7BoeObIPJNrvTjw/L9tOVKaEL0bkFHJw0VaN3PDQj0lFsQ12
         iHpxFWbOZoMG5RfQZ8w8jv5NpLYimoB4clEzruhTzR3cmfB0A5VxrAoDuuZW9AgxFMG2
         7hhPVfSJPOBY1paB0mZB0DXXlkN5F6MgN1gVBYmAJIOS8tAyhZTn2SS8ArElZ9og9Trh
         STjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529676; x=1773134476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        b=nGuTpO3ByxyjjWH2tKgvQehhnLj3L1VHUegh6UFn9Z60eQlD1tg/xJBb10Kh4bUSEP
         YTjjKDswEqoZwpFvPZ9wIEOzbSzGwROyp3rx9ovIDwepfY2GhImOgdmCxodjRVrXVz+p
         Se/gSpfm7dx72pfJ62GfD7/Hnz3LVKnhKgoumXg5urpBgVDYH2wkfY+iybIvkkamghzJ
         LJaIdWxjTKCfKDtR4uiswi+skWBpIYFkW0Xy9l63k9aQd5d460EZrTss88JRcasaZEtA
         HPkRxCpIbSQjQoGYQa1mzndXxuD3h5wu6WZf/iSgaHQeg8pEaNzxZJhWI6Tciu6TqduC
         Y1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529676; x=1773134476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pkig2duPJVssDkbWxtWOY0gHaOnkUNJGF+RUH4/MX7E=;
        b=ZAULDAViS8iewLCN2jZmeIUKXLvMXDdP6pZzXMGH434tXFqMseCt3/9vZ9ojmtS207
         VdFob+6F3NDJIU+2gyyA9gkUEj3AI4S3Hhdll7KrucPwS1yDIi1NkCyuuXv1IDJNMRyT
         XRh0hatH2bG+25UCji92O40aKM0KEG2iWFbRBxgCFRvKO7pZOdnZ8xd8MCEEUSeUAi1O
         8IJcu1CrW+m/cewbSpbsE0JYJUIYBQMQKlFvA8TLvc/YAmfL0yzinsEXY7dTTMpqncWo
         LHWf2xbMz4AOhL6X4ryjbIywgzk/DdzrQLSNRix5UslP3PsDDfJDGagOZeq0dPwVyztj
         Hv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI9nJFRjEhe5mMfnFpXEeS02hDcQOJgnfI63ZYQOjDYd9oZpDRimSJ/US/jjbzsXrXYCoHLqMz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SK8rq1zZL77gQXehwp+6xxun5//W+C7HH8OF8U/muNOjBnzz
	2Lld467+qfoQE/JCIWogRTS0iN+K++TV8Z1twXwmhqT9pEstzxj/JMQyYtD1pwQhxOVhzp6h68p
	NX06VwudoX5eoPbgb0HlQJvk11Z/fhE8=
X-Gm-Gg: ATEYQzxgcEXHBqEKKmLBMe3RMNClnITvgc/IP0dMwnHuhCSooj5PCptsbVVjaNNpw+t
	6IqnG4rtyGUFIjbbdeTW0l4n1XrP2UxVxuoffRfTd31YAEgSqHaihx7DeLaWdFrkbJe3U674W7w
	VBmAXRGVIeE4kYD33j1nTNgk63FO3vpd3JeogKfZ23im5y2UXhU1YFXLLXXwLFxR9cnHdMNLnO0
	ol0FH02R+jhyFLmti5QrSMvx7D/dh+ABW9mpDYpo5AWWoO/uIfZtGRePXeQfPGy3DfHasPp/QwS
	9M0+c0q+uWoSrRqOMB60/grIpliD433PmXtZEmrrHBRTWLY+/BU=
X-Received: by 2002:a17:907:3d51:b0:b87:10fd:b590 with SMTP id
 a640c23a62f3a-b9376590b83mr865582266b.60.1772529675436; Tue, 03 Mar 2026
 01:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs> <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
In-Reply-To: <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 10:21:04 +0100
X-Gm-Features: AaiRm535KwsgAVHj6EheTjrAtrSsGztnAGaoLe1OJY2V4Cm-WW3-sgOnbmd3S6E
Message-ID: <CAOQ4uxgmYNWCs18+WU9-7QDkhp0f_xX6nvKiyDhS8gZzfUXXXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] generic: test fsnotify filesystem error reporting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de, 
	gabriel@krisman.be, jack@suse.cz, fstests@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:40=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Test the fsnotify filesystem error reporting.

For the record, I feel that I need to say to all the people whom we pushed =
back
on fanotify tests in fstests until there was a good enough reason to do so,
that this seems like a good reason to do so ;)

But also for future test writers, please note that FAN_FS_ERROR is an
exception to the rule and please keep writing new fanotify/inotify tests in=
 LTP
(until there is a good enough reason...)

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  src/Makefile           |    2
>  src/fs-monitor.c       |  155 +++++++++++++++++++++++++++++++++
>  tests/generic/1838     |  228 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/generic/1838.out |   20 ++++
>  4 files changed, 404 insertions(+), 1 deletion(-)
>  create mode 100644 src/fs-monitor.c
>  create mode 100755 tests/generic/1838
>  create mode 100644 tests/generic/1838.out
>
>
...

> diff --git a/tests/generic/1838 b/tests/generic/1838
> new file mode 100755
> index 00000000000000..087851ddcbdb44
> --- /dev/null
> +++ b/tests/generic/1838
> @@ -0,0 +1,228 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1838
> +#
> +# Check that fsnotify can report file IO errors.
> +
> +. ./common/preamble
> +_begin_fstest auto quick eio selfhealing
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       test -n "$fsmonitor_pid" && kill -TERM $fsmonitor_pid
> +       rm -f $tmp.*
> +       _dmerror_cleanup
> +}
> +
> +# Import common functions.
> +. ./common/fuzzy
> +. ./common/filter
> +. ./common/dmerror
> +. ./common/systemd
> +
> +case "$FSTYP" in
> +xfs)
> +       # added as a part of xfs health monitoring
> +       _require_xfs_io_command healthmon
> +       # no out of place writes
> +       _require_no_xfs_always_cow
> +       ;;
> +ext4)
> +       # added at the same time as uevents
> +       modprobe fs-$FSTYP
> +       test -e /sys/fs/ext4/features/uevents || \
> +               _notrun "$FSTYP does not support fsnotify ioerrors"
> +       ;;
> +*)
> +       _notrun "$FSTYP does not support fsnotify ioerrors"
> +       ;;
> +esac
> +

_require_fsnotify_errors ?

> +_require_scratch
> +_require_dm_target error
> +_require_test_program fs-monitor
> +_require_xfs_io_command "fiemap"
> +_require_odirect
> +
> +# fsnotify only gives us a file handle, the error number, and the number=
 of
> +# times it was seen in between event deliveries.   The handle is mostly =
useless
> +# since we have no generic way to map that to a file path.  Therefore we=
 can
> +# only coalesce all the I/O errors into one report.
> +filter_fsnotify_errors() {
> +       _filter_scratch | \
> +               grep -E '(FAN_FS_ERROR|Generic Error Record|error: 5)' | =
\
> +               sed -e "s/len=3D[0-9]*/len=3DXXX/g" | \
> +               sort | \
> +               uniq
> +}

move to common/filter?

Apart from those nits, no further comments.

Thanks,
Amir.
