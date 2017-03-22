Received: from mail-oi0-f66.google.com ([209.85.218.66]:34419 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759675AbdCVPI3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Mar 2017 11:08:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id w81so8955201oig.1
        for <fstests@vger.kernel.org>; Wed, 22 Mar 2017 08:08:28 -0700 (PDT)
In-Reply-To: <20170322140618.GQ21915@dhcp12-143.nay.redhat.com>
References: <1490165188-488-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxjeZaZPE6W3wvBmpu4Daf9UkiL4DhiRQDB6F0POkr8bJQ@mail.gmail.com> <20170322140618.GQ21915@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Mar 2017 11:08:27 -0400
Message-ID: <CAOQ4uxhkbvSjRPfN8GuW31=FqPLqbZ5NDppia_hhBaD9Rd_7-Q@mail.gmail.com>
Subject: Re: [PATCH] common/rc: support gluster volume start with a slash
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, ndevos@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 22, 2017 at 10:06 AM, Zorro Lang <zlang@redhat.com> wrote:
> On Wed, Mar 22, 2017 at 06:34:00AM -0400, Amir Goldstein wrote:
>> On Wed, Mar 22, 2017 at 2:46 AM, Zorro Lang <zlang@redhat.com> wrote:
>> > The format of glusterfs' TEST_DEV or SCRATCH_DEV is XXX:XXX or
>> > XXX:/XXX, but xfstests can't accept the latter now. So change
>>
>> Why can't xfstest accept the latter?
>
> Because I use "\w:\w" in commit "4cbc0a0 fstests: add GlusterFS support".
> More details please see below.
>
>>
>> > the regular expression from "\w:\w" to ":/?", to accept more
>> > glusterfs device format.
>> >
>> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>> > ---
>> >
>> > Hi,
>> >
>> > According to the feedback from glusterfs developer:
>> >
>> > "Yes, it would be good to have an optional "/" after the ":". It is not
>> > required, but would probably help when someone runs the tests with the
>> > "hostname:/volume" device format."
>> >
>>
>> The developer also said
>> "We mostly use the format of 192.168.1.1:/testvol, matching the way NFS"
>> If we can enforce the more common format which xfstest already expects
>> for nfs*|ceph)
>> Why would we want to support another optional format and have a special
>> test case for it?
>
> Niels is the developer of glusterfs' NFS module (sorry, I forgot its proj=
ect
> name), he test it likes test NFS:
>   mount -t nfs 192.168.1.1:/XXXX /mnt
>
> So he only can use XXXX:/XXX format, because xfstests limit that format
> to mount NFS.
>
>>
>> > Maybe there's a slash before the gluster volume name. This patch
>> > try to support this format.
>> >
>> > Thanks,
>> > Zorro
>> >
>> >  common/rc | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/common/rc b/common/rc
>> > index edfba5d..e1ab2c6 100644
>> > --- a/common/rc
>> > +++ b/common/rc
>> > @@ -1496,7 +1496,7 @@ _require_scratch_nocheck()
>> >  {
>> >      case "$FSTYP" in
>> >         glusterfs)
>> > -               echo $SCRATCH_DEV | grep -q "\w:\w" > /dev/null 2>&1
>> > +               echo $SCRATCH_DEV | egrep -q ":/?" > /dev/null 2>&1
>
> As I know, mount a glusrerfs always do like this:
>   mount -t glusterfs 192.169.1.1:testvol /mnt
> or
>   mount -t glusterfs 192.169.1.1:/testvol /mnt
>
> So glusterfs can use XXXX:XXX or XXXX:/XXX format, but if mount a nfs,
> we only can use XXXX:/XXX format.
>
> So that's why NFS use `grep -q ":/"`, but glusterfs use `egrep -q ":/?"`
>

I understand.
What I am saying is that if glusterfs *can* use XXXX:/XXX
and a file system tester will dedicate a specific mount for xfstests,
so tester can use the NFS format for that mount and we can require that.

Is that really a big deal for the tester?

If we do that we will have less special cases for format of *_DEV
and I think that is a gain.
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DsqWPpcSQ0qX15lZGhPwlQr1tfc1EWw5ExsYYn9WJjT8&s=3DPbvRDVuhCNwpDUHTRaNZ6mz0=
lwZDQwL6svf0SzGvu7A&e=3D=20
