Received: from mail-ot0-f193.google.com ([74.125.82.193]:33334 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934151AbdCVKeC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Mar 2017 06:34:02 -0400
Received: by mail-ot0-f193.google.com with SMTP id i50so15660787otd.0
        for <fstests@vger.kernel.org>; Wed, 22 Mar 2017 03:34:01 -0700 (PDT)
In-Reply-To: <1490165188-488-1-git-send-email-zlang@redhat.com>
References: <1490165188-488-1-git-send-email-zlang@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Mar 2017 06:34:00 -0400
Message-ID: <CAOQ4uxjeZaZPE6W3wvBmpu4Daf9UkiL4DhiRQDB6F0POkr8bJQ@mail.gmail.com>
Subject: Re: [PATCH] common/rc: support gluster volume start with a slash
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, ndevos@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 22, 2017 at 2:46 AM, Zorro Lang <zlang@redhat.com> wrote:
> The format of glusterfs' TEST_DEV or SCRATCH_DEV is XXX:XXX or
> XXX:/XXX, but xfstests can't accept the latter now. So change

Why can't xfstest accept the latter?

> the regular expression from "\w:\w" to ":/?", to accept more
> glusterfs device format.
>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>
> Hi,
>
> According to the feedback from glusterfs developer:
>
> "Yes, it would be good to have an optional "/" after the ":". It is not
> required, but would probably help when someone runs the tests with the
> "hostname:/volume" device format."
>

The developer also said
"We mostly use the format of 192.168.1.1:/testvol, matching the way NFS"
If we can enforce the more common format which xfstest already expects
for nfs*|ceph)
Why would we want to support another optional format and have a special
test case for it?

> Maybe there's a slash before the gluster volume name. This patch
> try to support this format.
>
> Thanks,
> Zorro
>
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index edfba5d..e1ab2c6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1496,7 +1496,7 @@ _require_scratch_nocheck()
>  {
>      case "$FSTYP" in
>         glusterfs)
> -               echo $SCRATCH_DEV | grep -q "\w:\w" > /dev/null 2>&1
> +               echo $SCRATCH_DEV | egrep -q ":/?" > /dev/null 2>&1
>                 if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
>                         _notrun "this test requires a valid \$SCRATCH_DEV"
>                 fi
> @@ -1584,7 +1584,7 @@ _require_test()
>  {
>      case "$FSTYP" in
>         glusterfs)
> -               echo $TEST_DEV | grep -q "\w:\w" > /dev/null 2>&1
> +               echo $TEST_DEV | egrep -q ":/?" > /dev/null 2>&1
>                 if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
>                         _notrun "this test requires a valid \$TEST_DEV"
>                 fi
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp=
-3A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZ=
YR8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&=
m=3DsOFnPHY2QhAN81NfL6asak_zXdrfW6RhlugKVBncYLI&s=3DyJiytpG_eCqCMJGVP0irt3M=
fTtk6ueexsRUQRH2Gb9c&e=3D=20
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DsOFnPHY2QhAN81NfL6asak_zXdrfW6RhlugKVBncYLI&s=3DyJiytpG_eCqCMJGVP0irt3Mf=
Ttk6ueexsRUQRH2Gb9c&e=3D=20
