Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFBC10F1D
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Dec 2022 12:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLYMvs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Dec 2022 07:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYMvr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Dec 2022 07:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F50962E2
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671972662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVcT5GImFQe7hTW9o2HDuSwFdLEVDkeZE/qzROIPkaE=;
        b=BTCrXl++xq0P9J9KJC4tlpWx4O9HLFF1BhpCxSvYTWcj8wZFqynh3RUzk0uUUDVmA8coRD
        HDN6pWP0c+uHM9g1XC7ULzqHj3uSj73nus+m0AcOqqLUwxccNqOzY7GB1iPZ0pDgzixA1m
        LgaCCGNDoV75bPjHo2R7T0lWeMjqG84=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-FlZMXpI-NS6GigF90H4suw-1; Sun, 25 Dec 2022 07:50:55 -0500
X-MC-Unique: FlZMXpI-NS6GigF90H4suw-1
Received: by mail-pf1-f199.google.com with SMTP id ay18-20020a056a00301200b00580e3b8a642so1272912pfb.16
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 04:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVcT5GImFQe7hTW9o2HDuSwFdLEVDkeZE/qzROIPkaE=;
        b=pWPNQBlpEs7z4OMs4uhOEHscl8FHyJzYPeLDq3ZCCGQfQKNWU05S5pZF+cwu1xQEMl
         pJzHBWc5sgcHwVF8m6m87jk6UkK1o/K5BFcv7jyP/5Np8DkA6hytvDG2dIeVQIK8zSO3
         9LDPWTHq5UjSV1oZwWCtKCzxsI502ch0+4mf39Km2vNrCje+FqlBGNrmk+gdK8DKSo/y
         KjOra99YfqqH7TzkoBu+JIWS7yVd+Xc3fv4i1DyKGcIk+Z2r8Ut32mBO41Yi/U243Crc
         9340t7Aztfz2Aju/FqBrHqwJ5S5RG+vEn+a8ZgxNC6sMs7OV1eH/XM1F6rlCIfxml8dx
         qUPQ==
X-Gm-Message-State: AFqh2koBPPjLB3o9EiQ4IKHGgHD3GODSIrYpqGj/A5GrTMx5q1fvdHwq
        +cxin5qIJob4BcNGu/cxZhS1/3ktmhu37dx1mTA6wHwz3FpWUZAoaaJofUBlnvF1lzYoa/BzTyI
        XbpBAdwVp6pEv3aKr8Q==
X-Received: by 2002:a05:6a20:6a91:b0:ad:5a4d:95b5 with SMTP id bi17-20020a056a206a9100b000ad5a4d95b5mr33677071pzb.40.1671972653674;
        Sun, 25 Dec 2022 04:50:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRlxkUk15LxQMopri1ERtwZcuURBQmjEy5zOdrQDaBANXtN7ITnVbDoUbuqybzz8/RnxAttQ==
X-Received: by 2002:a05:6a20:6a91:b0:ad:5a4d:95b5 with SMTP id bi17-20020a056a206a9100b000ad5a4d95b5mr33677061pzb.40.1671972653351;
        Sun, 25 Dec 2022 04:50:53 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b00561d79f1064sm5282251pfg.57.2022.12.25.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 04:50:52 -0800 (PST)
Date:   Sun, 25 Dec 2022 20:50:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/154: migrate to python3
Message-ID: <20221225125049.nczymsopzbzrwfbm@zlang-mailbox>
References: <20221223025642.33496-1-wqu@suse.com>
 <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
 <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 25, 2022 at 08:11:02PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/12/25 19:51, Zorro Lang wrote:
> > On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
> > > Test case btrfs/154 is still using python2 script, which is already EOL.
> > > Some rolling distros like Archlinux is no longer providing python2
> > > package anymore.
> > > 
> > > This means btrfs/154 will be harder and harder to run.
> > > 
> > > To fix the problem, migreate the python script to python3, this involves
> > > the following changes:
> > > 
> > > - Change common/config to use python3
> > > - Strong type conversion between string and bytes
> > >    This means, anything involved in the forged bytes has to be bytes.
> > > 
> > >    And there is no safe way to convert forged bytes into string, unlike
> > >    python2.
> > >    I guess that's why the author went python2 in the first place.
> > > 
> > >    Thankfully os.rename() still accepts forged bytes.
> > > 
> > > - Use bytes specific checks for invalid chars.
> > > 
> > > The updated script can still cause the needed conflicts, can be verified
> > > through "btrfs ins dump-tree" command.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   common/config                   |  2 +-
> > >   src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
> > >   tests/btrfs/154                 |  4 ++--
> > >   3 files changed, 19 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/common/config b/common/config
> > > index b2802e5e..e2aba5a9 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
> > >   export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
> > >   export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
> > >   export THIN_CHECK_PROG="$(type -P thin_check)"
> > > -export PYTHON2_PROG="$(type -P python2)"
> > > +export PYTHON3_PROG="$(type -P python3)"
> > 
> > How about:
> > 
> > export PYTHON_PROG="$(type -P python)"
> > export PYTHON2_PROG="$(type -P python2)"
> > export PYTHON3_PROG="$(type -P python3)"
> > 
> > maybe someone still need python2, or maybe someone doesn't care the version.
> 
> Even for distros which completely get rid of python2 and make python3
> default, there is still python3.
> And python is just a softlink to python3, which further links to the real
> python
> 
>  $ type -P python2
>  $ type -P python3
>  /usr/bin/python3
>  $ type -P python
>  /usr/bin/python
> 
>  $ ls -alh /usr/bin/python
>  lrwxrwxrwx 1 root root 7 Nov  1 22:18 /usr/bin/python -> python3
>  $ ls -alh /usr/bin/python3
>  lrwxrwxrwx 1 root root 10 Nov  1 22:18 /usr/bin/python3 -> python3.10
> 
> Secondly, for this particular case, we must distinguish python2 and python3,
> especially due to the strong requirement for string encoding.
> 
> 
> So to your PYTHON_PROG usage, no, it's not good at all, it's going to be
> distro dependent and will be a disaster if some one is using PYTHON_PROG.
> 
> For PYTHON2_PROG, there is no usage of it any more, thus I see now reason to
> define it.

OK, due to only btrfs/154 uses this PYTHON?_PROG thing now, we can talk about
that later. This patch looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Zorro
> > 
> > >   export SQLITE3_PROG="$(type -P sqlite3)"
> > >   export TIMEOUT_PROG="$(type -P timeout)"
> > >   export SETCAP_PROG="$(type -P setcap)"
> > > diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
> > > index 6c08fcb7..d29bbb70 100755
> > > --- a/src/btrfs_crc32c_forged_name.py
> > > +++ b/src/btrfs_crc32c_forged_name.py
> > > @@ -59,9 +59,10 @@ class CRC32(object):
> > >       # deduce the 4 bytes we need to insert
> > >       for c in struct.pack('<L',fwd_crc)[::-1]:
> > >         bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
> > > -      bkd_crc ^= ord(c)
> > > +      bkd_crc ^= c
> > > -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
> > > +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
> > > +          bytes(s[pos:], 'ascii')
> > >       return res
> > >     def parse_args(self):
> > > @@ -72,6 +73,12 @@ class CRC32(object):
> > >                           help="number of forged names to create")
> > >       return parser.parse_args()
> > > +def has_invalid_chars(result: bytes):
> > > +    for i in result:
> > > +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
> > > +            return True
> > > +    return False
> > > +
> > >   if __name__=='__main__':
> > >     crc = CRC32()
> > > @@ -80,12 +87,15 @@ if __name__=='__main__':
> > >     args = crc.parse_args()
> > >     dirpath=args.dir
> > >     while count < args.count :
> > > -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
> > > +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
> > >       forgename = crc.forge(wanted_crc, origname, 4)
> > > -    if ("/" not in forgename) and ("\x00" not in forgename):
> > > +    if not has_invalid_chars(forgename):
> > >         srcpath=dirpath + '/' + str(count)
> > > -      dstpath=dirpath + '/' + forgename
> > > -      file (srcpath, 'a').close()
> > > +      # We have to convert all strings to bytes to concatenate the forged
> > > +      # name (bytes).
> > > +      # Thankfully os.rename() can accept bytes directly.
> > > +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
> > > +      open(srcpath, mode="a").close()
> > >         os.rename(srcpath, dstpath)
> > >         os.system('btrfs fi sync %s' % (dirpath))
> > >         count+=1;
> > > diff --git a/tests/btrfs/154 b/tests/btrfs/154
> > > index 240c504c..6be2d5f6 100755
> > > --- a/tests/btrfs/154
> > > +++ b/tests/btrfs/154
> > > @@ -21,7 +21,7 @@ _begin_fstest auto quick
> > >   _supported_fs btrfs
> > >   _require_scratch
> > > -_require_command $PYTHON2_PROG python2
> > > +_require_command $PYTHON3_PROG python3
> > >   # Currently in btrfs the node/leaf size can not be smaller than the page
> > >   # size (but it can be greater than the page size). So use the largest
> > > @@ -42,7 +42,7 @@ _scratch_mount
> > >   #    ...
> > >   #
> > > -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> > > +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> > >   echo "Silence is golden"
> > >   # success, all done
> > > -- 
> > > 2.39.0
> > > 
> > 
> 

