Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC1C4332F
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Dec 2022 11:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiLYLwn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Dec 2022 06:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLwm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Dec 2022 06:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9DDEA
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671969114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCxE+7UiMVvRtvAbvK6NVI5FLsNPw0Ca9220qsuttJ0=;
        b=JQt3scWDHE6cXZAp2znybT6a8arMGogAv6+Wnrb7NBEIx9oH/S3o1aYDBIaGEEGwE5KHVG
        t1ghQzdtCkYSqG5fYGsN1gI9HAqqP/3ZAnUAd08OrxVGc5lLV33MsNb+c95Usv2pKOemIq
        nTf7L79mN5acZMPyhFfpmOLX+hEE76U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-m-FYLHLcN76o5HKdDXNpeQ-1; Sun, 25 Dec 2022 06:51:52 -0500
X-MC-Unique: m-FYLHLcN76o5HKdDXNpeQ-1
Received: by mail-pl1-f198.google.com with SMTP id s2-20020a170902ea0200b0019247629ee5so6555251plg.17
        for <fstests@vger.kernel.org>; Sun, 25 Dec 2022 03:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCxE+7UiMVvRtvAbvK6NVI5FLsNPw0Ca9220qsuttJ0=;
        b=BZNhlucjjNQ+RPv/TC1Yioozxj7mWVmYlComNojX1CNLv96bogs62vlsUwL0MgMCs+
         p9BcspQ4VaFhQut7/SaCzhqyX5+yb36fzpiuD+n9eEoLF2snmsBFdfdLgy2z3EAqlQE0
         Q5yGpChATvMtJ6UOR56rpdJ6U9lOzQOX011BIe5LRH/zwSDBc6qFxu6O+Tmfhns1MTAl
         7zsVmO3T5be3YtUPVY2YJF+lCqR1GqpQgFocYvQjQL54NSrHVOgwSMpbOS8R5sBbHWlW
         gc/eWm8DSb8B/FYUMeJf8KRNk3JzhFCjk660maL4cdAVYpTVh05m3CHNEA9LVJtIPSml
         NWtw==
X-Gm-Message-State: AFqh2kpH2U3AXZW5rCmOqQJmWsYcCx5awJ2/TOWxK47GBfTc5sQgHFnh
        qzY52NJwTedtsDVgoI7xy1QKNux04Wii9gBdibFW1f2CFLJWT/EuNLjDthbWB5cBAdJg68pO1SG
        aoQqfZq7PlcQeJPWvLw==
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr43672498plg.46.1671969111183;
        Sun, 25 Dec 2022 03:51:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNU/3kaxOzkhCV+PE8+yegjc0HgACQfXkAsOVEJ6hxHbCu54AHThH9+RvHudqh3lHGXSZlag==
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr43672481plg.46.1671969110882;
        Sun, 25 Dec 2022 03:51:50 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b00176ab6a0d5fsm5298960pla.54.2022.12.25.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:51:50 -0800 (PST)
Date:   Sun, 25 Dec 2022 19:51:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/154: migrate to python3
Message-ID: <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
References: <20221223025642.33496-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223025642.33496-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
> Test case btrfs/154 is still using python2 script, which is already EOL.
> Some rolling distros like Archlinux is no longer providing python2
> package anymore.
> 
> This means btrfs/154 will be harder and harder to run.
> 
> To fix the problem, migreate the python script to python3, this involves
> the following changes:
> 
> - Change common/config to use python3
> - Strong type conversion between string and bytes
>   This means, anything involved in the forged bytes has to be bytes.
> 
>   And there is no safe way to convert forged bytes into string, unlike
>   python2.
>   I guess that's why the author went python2 in the first place.
> 
>   Thankfully os.rename() still accepts forged bytes.
> 
> - Use bytes specific checks for invalid chars.
> 
> The updated script can still cause the needed conflicts, can be verified
> through "btrfs ins dump-tree" command.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/config                   |  2 +-
>  src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
>  tests/btrfs/154                 |  4 ++--
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/common/config b/common/config
> index b2802e5e..e2aba5a9 100644
> --- a/common/config
> +++ b/common/config
> @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
>  export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
>  export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
>  export THIN_CHECK_PROG="$(type -P thin_check)"
> -export PYTHON2_PROG="$(type -P python2)"
> +export PYTHON3_PROG="$(type -P python3)"

How about:

export PYTHON_PROG="$(type -P python)"
export PYTHON2_PROG="$(type -P python2)"
export PYTHON3_PROG="$(type -P python3)"

maybe someone still need python2, or maybe someone doesn't care the version.

Thanks,
Zorro

>  export SQLITE3_PROG="$(type -P sqlite3)"
>  export TIMEOUT_PROG="$(type -P timeout)"
>  export SETCAP_PROG="$(type -P setcap)"
> diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
> index 6c08fcb7..d29bbb70 100755
> --- a/src/btrfs_crc32c_forged_name.py
> +++ b/src/btrfs_crc32c_forged_name.py
> @@ -59,9 +59,10 @@ class CRC32(object):
>      # deduce the 4 bytes we need to insert
>      for c in struct.pack('<L',fwd_crc)[::-1]:
>        bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
> -      bkd_crc ^= ord(c)
> +      bkd_crc ^= c
>  
> -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
> +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
> +          bytes(s[pos:], 'ascii')
>      return res
>  
>    def parse_args(self):
> @@ -72,6 +73,12 @@ class CRC32(object):
>                          help="number of forged names to create")
>      return parser.parse_args()
>  
> +def has_invalid_chars(result: bytes):
> +    for i in result:
> +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
> +            return True
> +    return False
> +
>  if __name__=='__main__':
>  
>    crc = CRC32()
> @@ -80,12 +87,15 @@ if __name__=='__main__':
>    args = crc.parse_args()
>    dirpath=args.dir
>    while count < args.count :
> -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
> +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
>      forgename = crc.forge(wanted_crc, origname, 4)
> -    if ("/" not in forgename) and ("\x00" not in forgename):
> +    if not has_invalid_chars(forgename):
>        srcpath=dirpath + '/' + str(count)
> -      dstpath=dirpath + '/' + forgename
> -      file (srcpath, 'a').close()
> +      # We have to convert all strings to bytes to concatenate the forged
> +      # name (bytes).
> +      # Thankfully os.rename() can accept bytes directly.
> +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
> +      open(srcpath, mode="a").close()
>        os.rename(srcpath, dstpath)
>        os.system('btrfs fi sync %s' % (dirpath))
>        count+=1;
> diff --git a/tests/btrfs/154 b/tests/btrfs/154
> index 240c504c..6be2d5f6 100755
> --- a/tests/btrfs/154
> +++ b/tests/btrfs/154
> @@ -21,7 +21,7 @@ _begin_fstest auto quick
>  
>  _supported_fs btrfs
>  _require_scratch
> -_require_command $PYTHON2_PROG python2
> +_require_command $PYTHON3_PROG python3
>  
>  # Currently in btrfs the node/leaf size can not be smaller than the page
>  # size (but it can be greater than the page size). So use the largest
> @@ -42,7 +42,7 @@ _scratch_mount
>  #    ...
>  #
>  
> -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>  echo "Silence is golden"
>  
>  # success, all done
> -- 
> 2.39.0
> 

