Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99425C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 14:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiGFOl2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiGFOl2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 10:41:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E524960
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 07:41:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 266Ef9Ua017711
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Jul 2022 10:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657118470; bh=X3faUAXsBBc/Efzkz7ZlQj9FX9VbaCR+7KIUWFnN17c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gJjq3SHn3d/SGRTSuglZlJDca+99wPnuKOuT/+8pweBlNyw0N9mddd6rElYl8X4I8
         73CPrzp3ZrJDYZ5FPCWhVLxXImr/HRroAM0bKQvba/pU5qIKwgcmN3bgLtXsXXRC4s
         5vLc49uehUB3Fmc462yfEgt3ey+kWxJzBsvhguEW6s/TAVYMabZ/2Kvu104cEMESxp
         cV5R8+86MnpxNHQQKY/lV9cgrg0OEZI0LgfY5HFxIgdXawR6NeLpApdvZzDYg66LMF
         iW7W4OVmOWPTythVkIjSVPxGPVURmM85GALbtj6Ssmn5pc+2H8Ui3Au3v2Mtj+JGJi
         n9pm5DI4M2xlg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3EB9D15C3E94; Wed,  6 Jul 2022 10:41:09 -0400 (EDT)
Date:   Wed, 6 Jul 2022 10:41:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/2] xfs test excluses needed for realtime_28k_logdev
Message-ID: <YsWfBbe/EADQHNgv@mit.edu>
References: <20220629125207.176710-1-tytso@mit.edu>
 <YsS6PQiy+4SPavpA@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsS6PQiy+4SPavpA@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 03:25:01PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 08:52:05AM -0400, Theodore Ts'o wrote:
> > These are tests in my out-of-tree patches to xfstests, which were
> > cherry-picked from Darrick's out-of-tree patches.  They are needed to
> > prevent a huge whackload (that's a technical term) of test failures in
> > the xfs/realtime_28k_logdev test config, which uses:
> > 
> > XFS_MKFS_OPTIONS='-d rtinherit=1 -m reflink=0,rmapbt=0 -r extsize=28k '
> > 
> > and uses an external logdevice as well as an external realtime device.
> > 
> > This test config is being used in the xfs 5.15 backports testing,
> > since it's one of Darrick's upstream acceptance test configs.
> > 
> > Darrick, any objections if I ask Zorro to consider these for upstream
> > xfstests?
> 
> Hmm, maybe I should post the most recent version of this.  Ok, I'll move
> towards upstream head and send it in a day or two.

Many thanks!

I'll be on the lookout of your patches and drop the older versions of
the aptch (from November 2021) from my tree once they show up.

    	  		       	       - Ted
