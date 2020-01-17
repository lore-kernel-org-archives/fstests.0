Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F250C33CB1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 10:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020DA2082F
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amMkOuNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAQKEM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:04:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44566 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgAQKEM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 05:04:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so11415554pgl.11
        for <fstests@vger.kernel.org>; Fri, 17 Jan 2020 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TbZXfypoK9GqWK8vq6VXQTIMKte65+dMYciyP/f/IGk=;
        b=amMkOuNBE2rkZlu2C8hcuto9vH/T3qfHJBROTKOBPjzxoXN8s/fOT7guuy9VLi8a8q
         ZIFaB35Jy6OOGROlQRMcXyM/68Sdy7ewUtK9n7Zh/hJ8RML8E9TD6+9A+IpPB8gyr3Af
         e4PQQwac21eDpwQ3/LoxpTe7ZFEB3aX5huvtAF11p/bMWKmb4xqRSraqXv2RazXBRe9B
         uFRGlJVoYNCsRUXNLjh/Y5EKuBjyfSfoHjdlw6bkLZk2ElYVHfpE5+0idMfFzoEON0xL
         +QRmNKrPIQEJGWbIr94CmM40rn8GoxXZp7zXwiWHAs2U6UAbS8M8PVU46eeTFNXn/1yR
         Azaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TbZXfypoK9GqWK8vq6VXQTIMKte65+dMYciyP/f/IGk=;
        b=DbfDOPVcsrXflNUVTkBupXzEM7kgRpZlLXdThR5naOovAiCu7xFdHNeFnlbb/vdfUk
         HSM8LG6SUQ5iD9841AKX+MmsLRGOqCC1vOHBdazH0W3/A3lp4i2fT4y9AKxFSfI3wA1T
         n+B7r/W7RctRQFQ8LMmOkoyDWzRiuZAHLo1HsZS5KHP66xVI43+z5fc3r7sE7dMQ84V+
         j4CaR51G0fBhtbQq2w+z9nlrAHWBtZnoHojfUYX2y59DifmVpHY93J3J3tOCcTeYh6sM
         XSb1BEtn2KH12tLzxjAyWfTVefphuhY890oXfM/faDhoGx+zTEJ6GOmqxhW2GXn97nU9
         Zegw==
X-Gm-Message-State: APjAAAVTipDAJf2/TsB4s18sWsTpOhIvAeENVDwn1zAEDQl5FJSNd6tp
        QFtM8mAPoLZipmEXXBKU3Xk=
X-Google-Smtp-Source: APXvYqyM2B1aS9W/6febvcAw11CDMACTss6PfDNio/eTGwQqu6eCoT+Rq89W9FCdclGN2x8QiC8I6w==
X-Received: by 2002:aa7:971d:: with SMTP id a29mr2177339pfg.29.1579255451574;
        Fri, 17 Jan 2020 02:04:11 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b193sm29446533pfb.57.2020.01.17.02.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:04:11 -0800 (PST)
Date:   Fri, 17 Jan 2020 18:04:00 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200117100400.ybbg4kzexfqup4ns@xzhoux.usersys.redhat.com>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
 <20200113224203.GA8241@magnolia>
 <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
 <20200115171923.GG8257@magnolia>
 <20200116074509.gnfkvvpy2jhahv3n@xzhoux.usersys.redhat.com>
 <20200116155233.GB2149943@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116155233.GB2149943@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 16, 2020 at 07:52:33AM -0800, Darrick J. Wong wrote:
> On Thu, Jan 16, 2020 at 03:45:09PM +0800, Murphy Zhou wrote:
> > On Wed, Jan 15, 2020 at 09:19:23AM -0800, Darrick J. Wong wrote:
> > > On Wed, Jan 15, 2020 at 12:21:32PM +0800, Murphy Zhou wrote:
> > > > On Mon, Jan 13, 2020 at 02:42:03PM -0800, Darrick J. Wong wrote:
> > > > > On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> > > > > > Usually the _mkfs helper will cleanup these directories at the
> > > > > > beginning of testcase. However, when testing on NFS, the cleanup
> > > > > > could be very slow and it is confusing that: We have already
> > > > > > started to run generic/176 but we get stuck in _mkfs, cleaning
> > > > > > up files left by the previous testcase generic/175.
> > > > > 
> > > > > Isn't this a general problem with the way nfs handles "mkfs" on scratch
> > > > > devices?  So you'd want to fix this once by doing the cleanup between
> > > > > tests instead of playing whackamole with whatever crazy file tests we
> > > > > think of next?
> > > > 
> > > > Hmm, it's hard to tell. Deleting these files at anywhere makes sense.
> > > > This patch is hardly a "fix", just trying to make it more clear.
> > > > 
> > > > > 
> > > > > > To be clear, cleanup testdir before exit.
> > > > > > 
> > > > > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > > > > ---
> > > > > >  tests/generic/175 | 1 +
> > > > > >  tests/generic/176 | 1 +
> > > > > >  2 files changed, 2 insertions(+)
> > > > > > 
> > > > > > diff --git a/tests/generic/175 b/tests/generic/175
> > > > > > index 79e5b3d6..bd966a28 100755
> > > > > > --- a/tests/generic/175
> > > > > > +++ b/tests/generic/175
> > > > > > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> > > > > >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> > > > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > > > >  
> > > > > > +rm -rf $testdir
> > > > > 
> > > > > Or put another way, this probably ought to be in _try_wipe_scratch_devs()
> > > > 
> > > > That's for devices I believe..
> > > 
> > > It exists to zap the scratch devices into enough of a clean state that
> > > whatever contents a test wrote to the scratch devices cannot easily
> > > (e.g. mount) leak into the next test.  IOWs, exactly where you'd want
> > > FSTYP=NFS to delete whatever junk is in the scratch mount.
> > > 
> > > Plus then you get a clean nfs scratch mount at the start of each test
> > > without needing to whackamole each test.
> > > 
> > > > Thanks,
> > > > Murphy
> > > > 
> > > > > 
> > > > > --D
> > > > > 
> > > > > >  # success, all done
> > > > > >  status=0
> > > > > >  exit
> > > > > > diff --git a/tests/generic/176 b/tests/generic/176
> > > > > > index a084578a..bc83762e 100755
> > > > > > --- a/tests/generic/176
> > > > > > +++ b/tests/generic/176
> > > > > > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> > > > > >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> > > > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > > > >  
> > > > > > +rm -rf $testdir
> > > 
> > > Also this will massively slow down generic/17[56] on btrfs/XFS
> > > considering that we don't care about deleting the massively reflinked
> > > file we created.
> > 
> > Deleting them would be a good testcase to me. After all the tests,
> > deleting them should not cause any problem, or spending to much
> > time. Leaving them behind and letting them get formatted by mkfs,
> > definitely will be faster, but may make potential problems not
> > discovered.
> 
> In that case, please rewrite the commit message to say that we're
> enhancing this stress test to include inactivation of the files it
> creates.
> 
> > If you think the deleting will be extremely slow, maybe it's time
> > to optimize how xfs deleting reflinked files.
> 
> They already exist & have been out for review for years:
> 
> https://lore.kernel.org/linux-xfs/157784092020.1362752.15046503361741521784.stgit@magnolia/

Great! Going to run some tests.

Thanks very much for reviewing!

Murphy

> 
> --D
> 
> > 
> > Thanks,
> > Murphy
> > 
> > > 
> > > --D
> > > 
> > > > > >  # success, all done
> > > > > >  status=0
> > > > > >  exit
> > > > > > -- 
> > > > > > 2.20.1
> > > > > > 
