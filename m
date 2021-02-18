Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71922C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9264EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 17:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBRRA0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 12:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231447AbhBRNnT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 08:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613655713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1P8UCz14BT44fgxmsZi61uMrn6b7XqXDZ57Sk35BSjo=;
        b=bmGn9s6cxqQ/O3CqT/p3RS2y+ffgxUmKDzXlBOjdRH5EYNTN9lFN6Iaf3DZ6Jn6j0S5oD0
        ZnwyXFgp3hvFrkCfs8JTZDH5rUenb7WwPq+0elKp9POJ8WG+vZkBQKkpIsS+gcx05kZ4yb
        bzxixYGhu24Jn3yEHM521ydYOvCulSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-pLpB2udiOvGx5IHfs4fKMg-1; Thu, 18 Feb 2021 08:41:51 -0500
X-MC-Unique: pLpB2udiOvGx5IHfs4fKMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8533636494
        for <fstests@vger.kernel.org>; Thu, 18 Feb 2021 13:41:49 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DBFB5C1C4
        for <fstests@vger.kernel.org>; Thu, 18 Feb 2021 13:41:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 756024A7C6;
        Thu, 18 Feb 2021 13:41:49 +0000 (UTC)
Date:   Thu, 18 Feb 2021 08:41:48 -0500 (EST)
From:   Zirong Lang <zlang@redhat.com>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Message-ID: <1113713488.55294765.1613655708457.JavaMail.zimbra@redhat.com>
In-Reply-To: <20210218134134.GM14354@localhost.localdomain>
References: <20210218085752.24123-1-xifeng@redhat.com> <20210218134134.GM14354@localhost.localdomain>
Subject: Re: [PATCH v3] common/rc: add filter in _test_inode_flag
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.72.13.99, 10.4.195.20]
Thread-Topic: common/rc: add filter in _test_inode_flag
Thread-Index: K52msS26n5Fx75tGe2q5xpmlr+Civw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "XiaoLi Feng" <xifeng@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021=
=E5=B9=B4 2 =E6=9C=88 18=E6=97=A5 =E4=B8=8B=E5=8D=88 9:41:34
> =E4=B8=BB=E9=A2=98: Re: [PATCH v3] common/rc: add filter in _test_inode_f=
lag
>=20
> On Thu, Feb 18, 2021 at 04:57:52PM +0800, XiaoLi Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> >=20
> > Add _filter_testdir_and_scratch to avoid _test_inode_flag failed when
> > mount point contains flag string.
> >=20
> > Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 649b1cfd..473188c1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3112,7 +3112,7 @@ _test_inode_flag()
> >  =09local flag=3D$1
> >  =09local file=3D$2
> > =20
> > -=09if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
> > +=09if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_testdir_and_scr=
atch |
> > grep -q "$flag" ; then
>=20
> I can't understand that. Could you give us an example about why we need t=
his
> filter before "quiet grep"? I think this line doesn't have any output
> (except xfs_io fails), so why a filter is needed?

Oh, I just saw your reply for V1 patch review:

"When test generic/608 for dax on xfs, "_check_xflag $t_file 0" is always
failed if the $f_file has dax string. Yes, here should also include filter
for TEST_DIR."

The _check_xflag() function as below:

_check_xflag()
{
        local target=3D$1
        local exp_xflag=3D$2

        if [ $exp_xflag -eq 0 ]; then
                _test_inode_flag dax $target && echo "$target has unexpecte=
d FS_XFLAG_DAX flag"
        else
                _test_inode_flag dax $target || echo "$target doesn't have =
expected FS_XFLAG_DAX flag"
        fi
}

Sure, if the $1 is something likes "/mnt/scratch/file", later echo "$target=
 ...." will print "/mnt/scratch".
If you're trying to fix this issue, I think you should filter the "$target"=
 in or behind _check_xflag(),
not in _test_inode_flag() which has no output.

Thanks,
Zorro

>=20
> Thanks,
> Zorro
>=20
> >  =09=09return 0
> >  =09fi
> >  =09return 1
> > --
> > 2.18.1
> >=20
>=20

