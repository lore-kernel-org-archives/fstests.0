Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690FCDB47E
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Oct 2023 18:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRSzf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRSze (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2023 14:55:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A04114
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 11:55:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F1F32188F;
        Wed, 18 Oct 2023 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697655331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZtVfPZZPb2VQzvChSOd0ysAHXASjJNQyRq2VAIB2Sc=;
        b=oGgsirvmBVNm9Q+X5qPZgCNBWfjBXfH8CWmH8/oak+nPpIAAEdsruX9zd4L2QV58waUkVu
        h0Y01wUITWdWyBPVTHZPHYEWI6EIbCGguy8N1vns+YDMGAjrOneE1uwo53UZ5U5F11TA43
        Zpa7WSHNKLe1HN2V7/Ej69CTqX32dqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697655331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZtVfPZZPb2VQzvChSOd0ysAHXASjJNQyRq2VAIB2Sc=;
        b=/VQB13GQyCJZ5V0IyvkZlwPpELoOSDC0Ykk+f1vyENOiKejpgcleD1+mVOKOf0q5rHoo3/
        goigXJcvbJk9b+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3135213915;
        Wed, 18 Oct 2023 18:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lHr5CyMqMGVlWwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Oct 2023 18:55:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ADB42A06B0; Wed, 18 Oct 2023 20:55:30 +0200 (CEST)
Date:   Wed, 18 Oct 2023 20:55:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/707: Test moving directory while being grown
Message-ID: <20231018185530.77phjvdwafrjkdoe@quack3>
References: <20230131125416.16120-1-jack@suse.cz>
 <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
 <20231012140903.tuwphwhp7fh7podq@quack3>
 <20231018141237.oorwr6f5vd54vybc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018141237.oorwr6f5vd54vybc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spamd-Result: default: False [-6.49 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.89)[99.55%]
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed 18-10-23 22:12:37, Zorro Lang wrote:
> On Thu, Oct 12, 2023 at 04:09:03PM +0200, Jan Kara wrote:
> > On Tue 31-01-23 22:25:44, Zorro Lang wrote:
> > > On Tue, Jan 31, 2023 at 01:54:16PM +0100, Jan Kara wrote:
> > > > Test how the filesystem can handle moving a directory to a different
> > > > directory (so that parent pointer gets updated) while it is grown. Ext4
> > > > and UDF had a bug where if the directory got converted to a different
> > > > type due to growth while rename is running, the filesystem got
> > > > corrupted.
> > > > 
> > > > Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > 
> > > Thanks, this version looks good to me,
> > > 
> > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > Guys, I have just noticed this patch didn't get merged. Can you please pick
> > it up? Thanks!
> 
> Hi Jan, I think it has been in fstests v2023.02.05 release, as:
> 
> commit da69ce70dfcdbd88d6f940d7c1ab346d5a1e5f82
> Author: Jan Kara <jack@suse.cz>
> Date:   Tue Jan 31 13:54:16 2023 +0100
> 
>     generic/707: Test moving directory while being grown
> 
> Isn't it same with this patch? Please check, and feel free to tell me
> if anything wrong.

Bah, sorry. Not sure why I didn't find it when grepping :-|. I'm sorry for
the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
