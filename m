Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1B12E78;
	Mon, 29 Jan 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561399; cv=none; b=eOOAWeofMwxqpiV4uKopfOWuBBPHcCcf3IBDFp4xACU+u/CuSUSYykjKX5mcmj7KzdawtdyqfrnpMhlh04crMs5qohKrrGrUt9cLozoK/4O3kqUB2l8D5ahHX1FkdPCrxKc5/2lAZ22FhoK+/6I2xfKmBSbeh+D3jiPLBSVJymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561399; c=relaxed/simple;
	bh=GpKgKuKYMIoYmYLCabXXiQbyLQ1M+QahqjzIAkKybfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o60YD/d/Kn3OsgTBMCUZSpRd1QMbI51qdM8B125r75U+AXAyw03YO6xv2DfCWrCKCM2aGcbUKZuD994O4HR02WSB/xA3gmOKRBnsd5DPdc3Jf5jWbJ5wmotFg0YHnZUyLxW2W/Jq0QH1D4CTZ1CbsaIi6HulcYeCv98YlYnOFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XE7QbbDo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XE7QbbDo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RtyjuxHa6SeEnpVzcZrxamEmgmi1e3L7vfG3ahPN4FA=; b=XE7QbbDoQ4tYoXjACmI/VXCvPe
	Wod1v7x9HQwrpE5wbOjH6szyiDmfYT5DPfvPsVtT2FDGf7hua+jnyXTxSjE3ZoE2T3wHlhLympwWY
	c2Szc/Z6lRoHcywCYXYNZelDsoGRB9qz+O73BVRDF9YKs1JvzwPOu89ci1Picg6ZXC813IywfF+nh
	qrZwu32ZBgVXvAHX38CJflvgq+0x3KODTA5R2Az4pacpl1XneUwn/zgKP9RnIH96LKAXGnXaLeTHO
	IyMH7C+ABIF28TydZdMPGSEUCtoC8uRdmPFpFEkGhnbzxJfU5JFjxhiNxMbFXgJAF1GGVOCg+phKb
	aSBxv44w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUYZo-0000000EIWn-0dGZ;
	Mon, 29 Jan 2024 20:49:56 +0000
Date: Mon, 29 Jan 2024 12:49:56 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: kdevops@lists.linux.dev, Chandan Babu R <chandan.babu@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>, p.raghav@samsung.com,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	zlang@redhat.com, Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	fstests@vger.kernel.org, gost.dev@samsung.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH kdevops] fstests: provide kconfig guidance for
 SOAK_DURATION
Message-ID: <ZbgPdDGzBGn3H8oc@bombadil.infradead.org>
References: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>
 <20240125222956.GD6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125222956.GD6188@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jan 25, 2024 at 02:29:56PM -0800, Darrick J. Wong wrote:
> On Thu, Jan 25, 2024 at 02:10:37PM -0800, Luis Chamberlain wrote:
> > The kdevops test runner has supported a custom SOAK_DURATION for
> > fstests, however we were not providing any guidance. This means folks
> > likely disable this. Throw a bone and provide some basic guidance and
> > use 2.5 hours as the default value. There are about 46 tests today
> > which use soak duration, this means if you are testing serially it
> > increase total test time by about 5 days than the previously known
> > total test time.
> > 
> > Note that if you are using kernel-ci and using a max loop goal of 100
> > that means 500 days extra, so about 1.3 years extra total test time.
> > If enabling soak duration you may want to then re-evaluate your loop
> > target goal for kernel-ci for kdevops.
> 
> Yikes, I wouldn't combine multiple runs with large SOAK_DURATION. ;)

To be clear, the don't run in parallel, it runs serially. The paralellism
happens by having each test section run on a different guest.

> You all might consider kicking all the soak tests over to a separate VM
> or VMs so that the long soak test do not hold up the rest of the run.

Yes indeed, these would be nice optimizations. At hallway talks at Linux
Plumbers it was clear that given sparsefile tests *are* proving
successful in finding issues, we should in theory be able run tests
using k8, and so the resource problems is hanlded by your max system
capacity. Solarflare folks has some PoC k8 [0] tests going with fstests
and it showed how test time reduces considerably, they added that PoC
because they *don't* have enough resources to run many VMs, but
coincidently that solution should help us scale more efficiently.

[0] https://lkml.kernel.org/r/ZThCAv60FDcxoCfI@CMGLRV3

> > diff --git a/workflows/fstests/Kconfig b/workflows/fstests/Kconfig
> > index 985a7847b6c7..bbd8927b3cd3 100644
> > --- a/workflows/fstests/Kconfig
> > +++ b/workflows/fstests/Kconfig
> > @@ -760,15 +760,23 @@ config FSTESTS_RUN_LARGE_DISK_TESTS
> >  	  to run. The "large disk" requirement is test dependent, but
> >  	  typically, it means a disk with capacity of at several 10G.
> >  
> > -config FSTESTS_SOAK_DURATION
> > -	int "Custom Soak duration to be used"
> > -	default 0
> > +config FSTESTS_ENABLE_SOAK_DURATION
> > +	bool "Enable custom soak duration time"
> >  	help
> > -	  Custom Soak duration to be used during test execution. If you set this
> > -	  to a non-zero value then fstests will increase the amount of time it
> > -	  takes to run certain tests which are time based and support using
> > -	  SOAK_DURATION. A moderate high value setting for this is 9900 which is
> > -	  2.5 hours.
> > +	  Enable soak duration to be used during test execution. If you are not
> > +	  interested in extending your testing then leave this disabled.
> > +
> > +	  Using a custom soak duration to a non-zero value then fstests will
> > +	  increase the amount of time it takes to run certain tests which are
> > +	  time based and support using SOAK_DURATION. A moderate high value
> > +	  setting for this is 9900 which is 2.5 hours.
> 
> "A moderately high setting for this is "2.5h" for 2.5 hours."
> 
> FWIW, the ./check parser translates floating point numbers with suffixes
> to integer seconds; see soak_duration.awk.

Oh neat!

> The part I don't know is if kdevops merely passes through the value as a
> string; or actually treats this as an integer.  If the latter, then
> please ignore my comment.

No we use an int for now. The above magic let's us add a few boools
which represent a sensible range or a custom manual seconds setting.

> > +if FSTESTS_ENABLE_SOAK_DURATION
> > +
> > +choice
> > +	prompt "Soak duration value to use"
> > +	default FSTESTS_SOAK_DURATION_HIGH
> > +
> > +config FSTESTS_SOAK_DURATION_CUSTOM
> > +	bool "Custom"
> > +	help
> > +	  You want to specify the value yourself.
> > +
> > +config FSTESTS_SOAK_DURATION_PATHALOGICAL
> 
> "PATHOLOGICAL", and yes that high a setting is pathological. ;)
> 
> (Unless you're allocating one soak-fstest per VM in which case "1w"
> might be appropriate.)

I think we can certainly get there, but we need first the robustness to
trust each target node / guest / etc. I do suspect the k8 approach might
get us there faster with less resources.

> > +
> > +config FSTESTS_SOAK_DURATION_MID
> > +	bool "Mid (1 hour)"
> > +	help
> > +	  Use 1 hour for soak duration.
> > +
> > +	  Using this with 46 tests known to use soak duration means your test
> > +	  time will increase by about 2 days if run serially.
> 
> I wonder, is there any way to scan the number of soak test to generate
> these figures automatically at configure time? 

You read my mind here, indeed that's desirable but we have no way to do
that today. Also, to get my current set list I had to a series of git
greps, but at least the Kconfig and the kdevops fstests watchdog pyhon
script already has an array with the tests which do use soak duration.
Indeed a much better approach is to have a static annotation we add to
all tests which use it so that we can scrape these later and also use
special resources for them as needed.

> I'd guess no, since kdevops kconfig comes before pulling and compiling, right?

kdevops makes heavy use of scripts on Kconfig for some hard-to-get
values. It also supports 'make dynconfig' which let's us dynamically
generate Kconfig files based on your setup, which otherwise would
not be possible. We do this to support PCI-E hotplug onto guests
for example, so you just have to use the menuconfig interface to setup
PCI hotplug onto guests. Such target could be extended if we want later
to support more special information, such as scraping the fstests git
tree we're going to use for actual tests, etc. We just have no the need
for that yet. At this point I think its overkill but, if we do want to
get there, indeed, its possible.

  Luis
